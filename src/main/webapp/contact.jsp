<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
        integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous" />
    <title>Contact Us</title>
    <style>
        body {
            background-color: #0275d8;
            color: white;
        }

        .center-content {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 92.5vh;
        }

        .cool-jumbotron {
            background-color: rgba(0, 0, 0, 0.7);
            padding: 40px 40px;
            text-align: left;
            border-radius: 10px;
            box-shadow: 0px 0px 10px 2px rgba(0, 0, 0, 0.4);
            margin-top:50px;
            margin-bottom:20px;
        }

        .cool-jumbotron h1 {
            font-size: 4rem;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.6);
        }

        .cool-jumbotron .lead {
            font-size: 1.5rem;
            margin-top: 10px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.6);
        }

        .btn-container {
            margin-top: 10px;
        }

        .btn {
            margin: 10px;
        }
    </style>
</head>

<body>
    <jsp:include page="header.jsp" />

    <div class="container center-content">
        <div class="jumbotron cool-jumbotron">
            <h1 class="display-4">Contact Us</h1>
            <p class="lead">Feel free to get in touch with us.</p>
            <div class="address-info">
                            <p>
                                <strong>Address:</strong><br>
                                A-201-207, Sankalp Iconic Tower,<br>
                                Near Iskcon Cross Road,<br>
                                Ahmedabad,
                                380058
                            </p>
                            <p>
                                <strong>Contact:</strong><br>
                                +14684688688<br>
                                +91 88888888888
                            </p>
                            <p>
                                <strong>Email:</strong><br>
                                sales@inexture.com<br>
                                info@inexture.com
                            </p>
                        </div>
        </div>
    </div>
    <jsp:include page="footer.jsp" />

    <script src="https://code.jquery.com/jquery-3.2.1.js" integrity="sha384-DZAnKJ/6XZ9si04Hgrsxu/8s717jcIzLy3oi35EouyE="
        crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"
        integrity="sha384-9aIt2nRpC12Uk9gqF8v5nHf5g5n0wwr45eC7Jk5G4C4z5P4f5uKbpz5UF5F5e5uKfs5r"
        crossorigin="anonymous"></script>
</body>

</html>
