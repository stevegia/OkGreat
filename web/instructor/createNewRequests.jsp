<% String title = "Create New Requests";%>
<%@include file="instructorHeader.jsp" %>

<body>
<div class="createNewRequestContent">
    <form NAME="form1" action="scheduleExam.jsp" method="post">
        <div style="padding-top: 10px"></div>
        <div class="container-fluid">
            <div class="md-col-10">

                <div class="row">
                    <div class="col-md-5">Test Type:</div>
                    <div class="col-md-5">
                        <div class="checkbox-inline">
                            <label><input type="checkbox" name="coursetog" onchange="switchToCourseView(this)">Ctoggle</label>
                        </div>
                        <div class="checkbox-inline">
                            <label><input type="checkbox" name="adhoctog" onchange="switchToAdHoc(this)">Ad Hoc</label>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-2">
                        Test Name
                    </div>
                    <div class="col-md-2">
                        <input type="text" class="form-control" placeholder="Test Name" aria-describedby="basic-addon2"
                               name="testname">
                    </div>
                </div>

                <div class="row" id="courseRow">
                    <div class="col-md-2">
                        Course:
                    </div>
                    <div class="col-md-2">
                        <input type="text" class="form-control" placeholder="Course" aria-describedby="basic-addon2"
                               name="course" id="course">
                    </div>
                </div>

                <div class="row" id="courseIdentifierRow">
                    <div class="col-md-2">
                        Course Identifier:
                    </div>
                    <div class="col-md-2">
                        <input type="text" class="form-control" placeholder="Course Identifier"
                               aria-describedby="basic-addon2" name="courseidentifier" id="courseidentifier">
                    </div>
                </div>

                <div class="row" id="sectionRow">
                    <div class="col-md-2">
                        Section:
                    </div>
                    <div class="col-md-2">
                        <input type="text" class="form-control" placeholder="Section" aria-describedby="basic-addon2"
                               name="section" id="section">
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-2">
                        Term:
                    </div>
                    <div class="col-md-2">
                        <select name="term">
                            <option value="1158">Fall 2015</option>
                            <option value="1161">Winter 2015</option>
                            <option value="1164">Spring 2016</option>
                            <option value="1166">Fall 2016</option>
                        </select>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-2"> Start Date and Time:</div>
                    <div class="col-md-2">
                        <div class="input-group date" data-provide="datepicker">
                            <input type="text" class="form-control" name="startdate">

                            <div class="input-group-addon">
                                <span class="glyphicon glyphicon-th"></span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <input name="starttime" type="text" class="form-control" placeholder=""
                               value="Start Time" required>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-2"> End Date and Time:</div>
                    <div class="col-md-2">
                        <div class="input-group date" data-provide="datepicker">
                            <input type="text" class="form-control" name="enddate">

                            <div class="input-group-addon">
                                <span class="glyphicon glyphicon-th"></span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <input name="endtime" type="text" class="form-control" placeholder=""
                               value="End Time" required>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-2">Duration in minutes</div>
                    <div class="col-md-2">
                        <input name="duration" type="number" class="form-control" placeholder=""
                               value="End Time" required>
                    </div>
                </div>

                <div style="padding-top: 20px"></div>

            </div>
        </div>

        <div id="adhocInformation" style="display:none">
            <div class="row">
                <div class="col-md-2"> Total Students</div>
                <div class="col-md-2">
                    <input type="number" class="form-control" placeholder="30" aria-describedby="basic-addon2"
                           onchange="totalStudentChange()" id="totalStudent" name="totalStudent">
                </div>
            </div>


            <h1 style="text-align:center">Students</h1>

            <div class="md-col-3">
                <div class="container">
                    <table class="table table-bordered">
                        <thead>
                        <tr>
                            <th>NetId</th>
                            <th>LastName</th>
                            <th>FirstName</th>
                        </tr>
                        </thead>
                        <tbody id="studentIds">


                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <input type="submit" value="Submit"/>


    </form>


    <script>
        function switchToCourseView() {
            $("#adhocInformation").css('display', 'none');
            $("#totalStudent").prop("disabled", true);

            $("#courseRow").css('display', 'block');
            $("#course").prop("disabled", false);
            $("#courseIdentifierRow").css('display', 'block');
            $("#courseidentifier").prop("disabled", false);
            $("#sectionRow").css('display', 'block');
            $("#section").prop("disabled", false);
        }
        function switchToAdHoc() {
            $("#adhocInformation").css('display', 'block');
            $("#totalStudent").prop("disabled", false);

            $("#courseRow").css('display', 'none');
            $("#course").prop("disabled", true);
            $("#courseIdentifierRow").css('display', 'none');
            $("#courseidentifier").prop("disabled", true);
            $("#sectionRow").css('display', 'none');
            $("#section").prop("disabled", true);
        }
        function totalStudentChange() {
            $("#studentIds").empty();

            var total = $("#totalStudent").val();
            for (var i = 0; i < total; i++) {
                var tr = "<tr>";
                var firstline = "<td> <input type='text' class='form-control' placeholder='netid' aria-describedby='basic-addon2' name='netid_" + i + "'></td>";
                var secondline = "<td> <input type='text' class='form-control' placeholder='lastname' aria-describedby='basic-addon2' name='lastname_" + i + "'></td>";
                var thirdline = "<td> <input type='text' class='form-control' placeholder='firstname' aria-describedby='basic-addon2' name='firstname_" + i + "'></td>";
                var addLine = tr + firstline + secondline + thirdline + tr;

                $("#studentIds").append(addLine);
            }


        }


    </script>


</div>

</body>

