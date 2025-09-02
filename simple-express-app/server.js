const express = require("express");
const app = express();

// 1. Use of == and != instead of === and !==
app.get("/equal", (req, res) => {
  if (req.query.value == 10) {
    res.send("Value is 10");
  } else if (req.query.flag != true) {
    res.send("Flag is not true");
  } else {
    res.send("No match");
  }
});

// 2. Use of arguments.caller and arguments.callee (should not be used)
function calleeExample() {
  // Using arguments.callee
  return arguments.callee.name;
}

function callerExample() {
  // Using arguments.caller
  return arguments.caller ? arguments.caller.name : "No caller";
}

app.get("/callee", (req, res) => {
  res.send("Callee: " + calleeExample());
});

app.get("/caller", (req, res) => {
  res.send("Caller: " + callerExample());
});

// 3. Array.prototype.sort() and Array.prototype.toSorted() should use a compare function
app.get("/sort", (req, res) => {
  const arr = [10, 2, 5, 1];
  // sort without compare function
  arr.sort();
  res.send("Sorted: " + arr.join(","));
});

app.get("/tosorted", (req, res) => {
  const arr = [10, 2, 5, 1];
  // toSorted without compare function
  const sortedArr = arr.toSorted();
  res.send("ToSorted: " + sortedArr.join(","));
});
