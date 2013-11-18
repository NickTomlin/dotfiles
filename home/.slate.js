S.cfga({
  "defaultToCurrentScreen": true,
  "secondsBetweenRepeat": 0.1,
  "checkDefaultsOnLoad": true,
  "focusCheckWidthMax": 3000
});

// Create Operations
var pushRight = slate.operation("push", {
  "direction" : "right",
  "style" : "bar-resize:screenSizeX/2"
});
var pushLeft = slate.operation("push", {
  "direction" : "left",
  "style" : "bar-resize:screenSizeX/2"
});
var pushTop = slate.operation("push", {
  "direction" : "top",
  "style" : "bar-resize:screenSizeY/2"
});
var fullscreen = slate.operation("move", {
  "x" : "screenOriginX",
  "y" : "screenOriginY",
  "width" : "screenSizeX",
  "height" : "screenSizeY"
});
// // Bind A Crazy Function to 1+ctrl
// slate.bind("ctrl:alt", function(win) {
//   // here win is a reference to the currently focused window
//   if (win.title() === "OMG I WANT TO BE FULLSCREEN") {
//     win.doOperation(fullscreen);
//     return;
//   }
//   var appName = win.app().name();
//   if (appName === "iTerm") {
//     win.doOperation(pushRight);
//   } else if (appName === "Google Chrome") {
//     win.doOperation(pushLeft);
//   } else {
//     win.doOperation(pushLeft);
//   }
// });


// stolen from https://github.com/jigish/dotfiles/blob/master/slate.js#L186
S.bnda({
  // // Resize Bindings
  // // NOTE: some of these may *not* work if you have not removed the expose/spaces/mission control bindings
  // "right:ctrl;cmd" : S.op("resize", { "width" : "+10%", "height" : "+0" }),
  // "left:ctrl;cmd" : S.op("resize", { "width" : "-10%", "height" : "+0" }),
  // "up:ctrl;cmd" : S.op("resize", { "width" : "+0", "height" : "-10%" }),
  // "down:ctrl;cmd" : S.op("resize", { "width" : "+0", "height" : "+10%" }),
  // "right:alt" : S.op("resize", { "width" : "-10%", "height" : "+0", "anchor" : "bottom-right" }),
  // "left:alt" : S.op("resize", { "width" : "+10%", "height" : "+0", "anchor" : "bottom-right" }),
  // "up:alt" : S.op("resize", { "width" : "+0", "height" : "+10%", "anchor" : "bottom-right" }),
  // "down:alt" : S.op("resize", { "width" : "+0", "height" : "-10%", "anchor" : "bottom-right" }),
  // Push Bindings
  // NOTE: some of these may *not* work if you have not removed the expose/spaces/mission control bindings
  "right:ctrl;cmd" : S.op("push", { "direction" : "right", "style" : "bar-resize:screenSizeX/2" }),
  "left:ctrl;cmd" : S.op("push", { "direction" : "left", "style" : "bar-resize:screenSizeX/2" }),
  "up:ctrl;cmd" : S.op("push", { "direction" : "up", "style" : "bar-resize:screenSizeY/2" }),
  "down:ctrl;cmd" : S.op("push", { "direction" : "down", "style" : "bar-resize:screenSizeY/2" }),
  "up,shift,ctrl,alt" : S.op("push", { "direction": "up", "style" : "bar-resize:screenSizeY/4"}),
  "right:ctrl;alt;cmd" : S.op("throw", { "screen" : "right", "width" : "screenSizeX", "height" : "screenSizeY" }),
  "left:ctrl;alt;cmd" : S.op("throw", { "screen" : "left", "width" : "screenSizeX", "height" : "screenSizeY" }),
  "up:ctrl;alt;cmd" : S.op("throw", { "screen" : "up", "width" : "screenSizeX", "height" : "screenSizeY" }),
  "down:ctrl;alt;cmd" : S.op("throw", { "screen" : "down", "width" : "screenSizeX", "height" : "screenSizeY" }),

  // Window Hints
  "esc:cmd" : S.op("hint"),
});
