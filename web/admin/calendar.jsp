<% String title = "calendar";%>
<%@include file="adminHeader.html"%>
<body>

<div id ="calendarChart"></div>
<script type="text/javascript">
  var calendar = $("#calenderChart").calendar(
          {
            tmpl_path: "../tmpls/",
            events_source: function () { return []; }
          });
</script>

<div class="appointmnetContent">


  <div class="dropdown">
    Term:
    <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
      Fall 2015
      <span class="caret"></span>
    </button>
    <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
      <li><a href="#">Spring 2016</a></li>
      <li><a href="#">Spring 2015</a></li>
      <li><a href="#">Fall 2014</a></li>

    </ul>
  </div>
</div>

<div id="calenderChart">



<script type="text/javascript">
  var calendar = $("#calenderChart").calendar(
          {
            tmpl_path: "../tmpls/",
            events_source: function () { return []; }
          });
</script>


</div>


</body>

</html>
