function ExecuteScript(strId)
{
  switch (strId)
  {
      case "5YYYCSWox9s":
        Script1();
        break;
  }
}

function Script1()
{
  window.parent.sendLessonCompletedEvent();
}

