<% String title = "Create New Requests";%>
<%@include file="instructorHeader.jsp"%>
<% List<Term> terms = retriever.getTerms();
%>
<div class="createNewRequestContent">
  <div class="dropdown">
    Term:
    <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
      Fall 2015
      <span class="caret"></span>
    </button>
    <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
      <%for(Term term : terms){
      %> <li onclick="submitTerm(<%=term.getId()%>,'<%=term.getTermName()%>')"><%=term.getTermName()%></li>
      <%}
      %>
    </ul>
  </div>
</div>
<div class="createNewRequestContent">
  <div class="container-fluid">

    <div class="md-col-6">
      <div class="row">
        <div class="col-md-2">Test Type: </div>
        <div class="col-md-3">
          <div class="checkbox-inline">
            <label><input type="checkbox" value="">Course</label>
          </div>
          <div class="checkbox-inline">
            <label><input type="checkbox" value="">Ad Hoc</label>
          </div>
        </div>
      </div>
      <div class="row">
        <div class="col-md-3">
        Test Name
          </div>
      </div>
      <div class="row">
        <div class="col-md-3">
          Bio Test
        </div>
      </div>
      <div class="row">
        <div class="col-md-2">
          Course Identifier:
        </div>
        <div class="col-md-2">
          <input type="text" class="form-control" placeholder="Course Identifier" aria-describedby="basic-addon2">
        </div>
      </div>
      <div class="row">
        <div class="col-md-2">
          Section:
        </div>
        <div class="col-md-2">
          <input type="text" class="form-control" placeholder="Section" aria-describedby="basic-addon2">
        </div>
      </div>
      <div class="row">
        <div class="col-md-2">
          Term:
        </div>
        <div class="col-md-2">
          <input type="text" class="form-control" placeholder="Term" aria-describedby="basic-addon2">

        </div>

      </div>
      <div class="row">
        Start Time and date
      </div>
      <div class="row">
        <div class="input-group">
          <input type="text" class="form-control" placeholder="Start Date" aria-describedby="basic-addon2">
          <input type="text" class="form-control" placeholder="Start Time" aria-describedby="basic-addon2">
        </div>

    </div>
      <div class="row">
        Start Time and date
      </div>
      <div class="row">
        <div class="input-group">
          <input type="text" class="form-control" placeholder="End Date" aria-describedby="basic-addon2">
          <input type="text" class="form-control" placeholder="End Time" aria-describedby="basic-addon2">

        </div>
        <div class="checkbox-inline">
          <label><input type="checkbox" value="">Notify Students By Email If Schedule Request is Accepted</label>
        </div>
      </div>
    </div>
  </div>
</div>
<div class="md-col-3">
  <div class="container">
    <h2>Students</h2>

    <table class="table table-bordered">
      <thead>
      <tr>
        <th>Date</th>
        <th>Start</th>
        <th>Regular Seats</th>
        <th>Select</th>

      </tr>
      </thead>
      <tbody>
      <tr>
        <td>11/15/12</td>
        <td>11:00pm</td>
        <td>3</td>

      </tr>

      </tbody>
    </table>
  </div>
</div>
<div class="md-col-3">
  <div class="container">
    <h2>Additional Info</h2>

    <table class="table table-bordered">
      <thead>
      <tr>
        <th>Date</th>
        <th>Start</th>
        <th>Regular Seats</th>
        <th>Select</th>

      </tr>
      </thead>
      <tbody>
      <tr>
        <td>11/15/12</td>
        <td>11:00pm</td>
        <td>3</td>

      </tr>

      </tbody>
    </table>
  </div>
</div>
<button type="button" class="btn-block ">Submit New Request</button>
</body>
</html>

