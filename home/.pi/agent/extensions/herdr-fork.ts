import { randomUUID } from "node:crypto";
import { SessionManager, type ExtensionAPI, type ExtensionContext } from "@earendil-works/pi-coding-agent";

type Layout = "vertical" | "horizontal" | "tab";

export function parseForkArgs(args: string): { layout: Layout; instructions: string } {
  const trimmed = args.trim();
  const [first = ""] = trimmed.split(/\s+/, 1);
  const layouts: Record<string, Layout> = {
    v: "vertical", vertical: "vertical",
    h: "horizontal", horizontal: "horizontal",
    t: "tab", tab: "tab",
  };
  const layout = layouts[first.toLowerCase()];
  return layout
    ? { layout, instructions: trimmed.slice(first.length).trimStart() }
    : { layout: "vertical", instructions: trimmed };
}

function lastCompletedEntryId(ctx: ExtensionContext): string | undefined {
  const branch = ctx.sessionManager.getBranch();
  for (let index = branch.length - 1; index >= 0; index--) {
    const entry = branch[index];
    if (entry.type === "message") {
      if (entry.message.role === "assistant" && entry.message.stopReason === "stop") return entry.id;
      if (entry.message.role === "user") return undefined;
    }
  }
  return undefined;
}

export default function (pi: ExtensionAPI) {
  let checkpoint: { sessionId: string; entryId: string } | undefined;

  pi.on("session_start", (_event, ctx) => {
    checkpoint = ctx.isIdle() ? completedCheckpoint(ctx) : undefined;
  });

  function completedCheckpoint(ctx: ExtensionContext) {
    const entryId = lastCompletedEntryId(ctx) && ctx.sessionManager.getLeafId();
    return entryId ? { sessionId: ctx.sessionManager.getSessionId(), entryId } : undefined;
  }

  pi.on("agent_settled", (event, ctx) => {
    if (!event.aborted && ctx.isIdle()) {
      checkpoint = completedCheckpoint(ctx) ?? checkpoint;
    }
  });

  async function runHerdr(args: string[]) {
    const result = await pi.exec("herdr", args, { timeout: 60_000 });
    if (result.code !== 0) throw new Error(result.stderr.trim() || `herdr ${args.slice(0, 2).join(" ")} failed`);
    return result.stdout;
  }

  async function fork(args: string, ctx: ExtensionContext) {
    if (ctx.mode !== "tui" || process.env.HERDR_ENV !== "1" || !process.env.HERDR_PANE_ID || !process.env.HERDR_WORKSPACE_ID) {
      ctx.ui.notify("Run this command from Pi inside a Herdr pane", "error");
      return;
    }

    const { layout, instructions } = parseForkArgs(args);
    const manager = ctx.sessionManager;
    const sourceFile = manager.getSessionFile();
    const branch = manager.getBranch();
    const current = ctx.isIdle() ? completedCheckpoint(ctx) : undefined;
    const entryId = current?.entryId ?? (checkpoint?.sessionId === manager.getSessionId() ? checkpoint.entryId : undefined);
    if (!sourceFile || !entryId || !branch.some((entry) => entry.id === entryId)) {
      ctx.ui.notify("No completed conversation point is available to fork", "error");
      return;
    }

    let paneId: string | undefined;
    let forkFile: string | undefined;
    try {
      // createBranchedSession changes its manager, so never call it on Pi's live manager.
      const copy = SessionManager.open(sourceFile, manager.getSessionDir());
      forkFile = copy.createBranchedSession(entryId);
      if (!forkFile) throw new Error("Could not save the forked session");

      const created = layout === "tab"
        ? await runHerdr(["tab", "create", "--workspace", process.env.HERDR_WORKSPACE_ID!, "--cwd", ctx.cwd, "--focus"])
        : await runHerdr(["pane", "split", "--current", "--direction", layout === "vertical" ? "right" : "down", "--cwd", ctx.cwd, "--focus"]);
      paneId = JSON.parse(created).result[layout === "tab" ? "root_pane" : "pane"].pane_id;

      await runHerdr(["agent", "start", `hf-${randomUUID().slice(0, 12)}`, "--kind", "pi", "--pane", paneId!, "--", "--session", forkFile]);
      if (instructions) await runHerdr(["agent", "prompt", paneId!, instructions]);
      ctx.ui.notify(`Fork opened in ${paneId}`, "info");
    } catch (error) {
      ctx.ui.notify(`Fork failed${paneId ? ` in ${paneId}` : ""}${forkFile ? ` (session ${forkFile})` : ""}: ${error instanceof Error ? error.message : String(error)}`, "error");
    }
  }

  pi.registerCommand("herdr-fork", { description: "Fork into a Herdr pane or tab: [v|h|t] [instructions]", handler: fork });
  pi.registerCommand("hf", { description: "Short alias for /herdr-fork", handler: fork });
}
