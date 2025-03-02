<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <title>CONTACT REGISTRATION PAGE</title>
</head>
<body>
<p  class="container text-center">Contact</p>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.bundle.min.js"></script>
    <div class="container mt-5">
        <form action="processform" method="post">
            <div class="form-group">
                <label for="formGroupExampleInput" class="form-label">User Name</label>
                <input type="text" class ="form-control" id="formGroupExampleInput" placeholder="Enter User Name" name="userName">
            </div>
            <div class="mb-3">
                <label for="formGroupExampleInput2" class="form-label">E-Mail</label>
                <input type="email" class ="form-control" id="formGroupExampleInput2" placeholder="Enter Mail" name="email">
            </div>
            <div class="container text-center">
                <button type="submit" class="btn btn-success">sing in</button>
            </div>
        </form>
    </div>
</body>
</html>