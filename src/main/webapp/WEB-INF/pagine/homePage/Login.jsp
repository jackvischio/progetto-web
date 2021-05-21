<%-- 
    Document   : Login
    Created on : 12-ago-2019, 14.33.11
    Author     : Mike_TdT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page errorPage="/WEB-INF/pagine/error.jsp"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Servizio Sanitario</title>
    <link rel="icon" href="assetsHome/img/favicon.ico">
    <link rel="shortcut icon" href="assetsHome/img/favicon.ico">
    <link rel="stylesheet" href="assetsHome/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic">
    <link rel="stylesheet" href="assetsHome/fonts/ionicons.min.css">
    <link rel="stylesheet" href="assetsHome/fonts/simple-line-icons.min.css">
    <link rel="stylesheet" href="assetsHome/css/Footer-Basic.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.8.2/css/lightbox.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/3.3.1/css/swiper.min.css">
    <link rel="stylesheet" href="assetsHome/css/Lightbox-Gallery.css">
    <link rel="stylesheet" href="assetsHome/css/Login-Form-Dark-1.css">
    <link rel="stylesheet" href="assetsHome/css/untitled.css">
    <style>
        .closebtn {
            padding-left: 15px;
            color: white;
            font-weight: bold;
            float: right;
            font-size: 20px;
            line-height: 18px;
            cursor: pointer;
            transition: 0.3s;
        }
        .closebtn:hover {
          color: black;
        }
        .alert-success {
            padding: 20px;
            background-color: green;
            color: white;
            opacity: 0.83;
            transition: opacity 0.6s;
            margin-bottom: 15px;
        }
        .alert {
            padding: 20px;
            background-color: red;
            color: white;
            opacity: 0.83;
            transition: opacity 0.6s;
            margin-bottom: 15px;
        }
    </style>
</head>

<body>
    <nav class="navbar navbar-expand navbar-expand-lg fixed-top">
        <a href="HomePage"><img src="assetsHome/img/paramedic-1136916_640.png" height="60" width="60" /></a>
    </nav>
    <c:if test="${!empty PasswordImpostata}">
        <nav class="alert-success navbar navbar-expand navbar-expand-lg fixed-top">
            <div class="container-fluid"> 
                <column><strong> Successo!</strong> Password impostata.</column>
                <column><span class="closebtn"  onclick="this.parentElement.parentElement.parentElement.style.display='none';">&times;</span></column>
            </div>
        </nav>
    </c:if>
    <c:if test="${!empty emailOK}">
        <nav class="alert-success navbar navbar-expand navbar-expand-lg fixed-top">
            <div class="container-fluid"> 
                <column><strong> Successo!</strong> Email inviata.</column>
                <column><span class="closebtn"  onclick="this.parentElement.parentElement.parentElement.style.display='none';">&times;</span></column>
            </div>
        </nav>
    </c:if>
    <c:if test="${!empty expired}">
        <nav class="alert navbar navbar-expand navbar-expand-lg fixed-top">
            <div class="container-fluid"> 
                <column><strong> Attenzione!</strong> Link scaduto, riprova.</column>
                <column><span class="closebtn"  onclick="this.parentElement.parentElement.parentElement.style.display='none';">&times;</span></column>
            </div>
        </nav>
    </c:if>
    <c:if test="${!empty codiceNO}">
        <nav class="alert navbar navbar-expand navbar-expand-lg fixed-top">
            <div class="container-fluid"> 
                <column><strong> Errore!</strong> Link non trovato.</column>
                <column><span class="closebtn"  onclick="this.parentElement.parentElement.parentElement.style.display='none';">&times;</span></column>
            </div>
        </nav>
    </c:if>
    <c:if test="${!empty errorLogin}">
        <nav class="alert navbar navbar-expand navbar-expand-lg fixed-top">
            <div class="container-fluid"> 
                <column><strong> Attenzione!</strong> Email o password errati.</column>
                <column><span class="closebtn"  onclick="this.parentElement.parentElement.parentElement.style.display='none';">&times;</span></column>
            </div>
        </nav>
    </c:if>
    <c:if test="${!empty errorDAO}">
        <nav class="alert navbar navbar-expand navbar-expand-lg fixed-top">
            <div class="container-fluid"> 
                <column><strong> Errore!</strong> Utente non presente in sistema.</column>
                <column><span class="closebtn"  onclick="this.parentElement.parentElement.parentElement.style.display='none';">&times;</span></column>
            </div>
        </nav>
    </c:if>
    <c:if test="${!empty errorGen}">
        <nav class="alert navbar navbar-expand navbar-expand-lg fixed-top">
            <div class="container-fluid"> 
                <column><strong> Attenzione!</strong> Un errore generale è stato rilevato, riprovare.</column>
                <column><span class="closebtn"  onclick="this.parentElement.parentElement.parentElement.style.display='none';">&times;</span></column>
            </div>
        </nav>
    </c:if>
    <c:if test="${!empty erroreGenerale}">
        <nav class="alert navbar navbar-expand navbar-expand-lg fixed-top">
            <div class="container-fluid"> 
                <column><strong> Attenzione!</strong> Un errore generale è stato rilevato, riprovare.</column>
                <column><span class="closebtn"  onclick="this.parentElement.parentElement.parentElement.style.display='none';">&times;</span></column>
            </div>
        </nav>
    </c:if>
<div class="login-dark">
    <form method="POST" action="${pageContext.servletContext.contextPath}/ChiamaLogin">
        <div class="illustration"><i class="icon ion-ios-locked-outline"></i></div>
        <div class="form-group"><input type="email" name="email" placeholder="Email" class="form-control" /></div>
        <div class="form-group"><input type="password" name="password" placeholder="Password" class="form-control" /></div>
        <div class="form-group">
            <div class="custom-control custom-checkbox">
                <input type="checkbox" name="ricordami" class="custom-control-input" id="customCheck6">
                <label class="custom-control-label" for="customCheck6">Ricordami</label>
            </div>
        </div>
        <div class="form-group"><button class="btn btn-primary btn-block" type="submit" onclick="this.disabled">ACCEDI</button></div>
        <a href="RecuperoPassword" class="forgot">Dimenticato la password?</a>
    </form>
</div>
<div class="footer-basic">
    <footer>    
        <div class="social"><a href="https://www.instagram.com/serviziosanitarioweb/"><i class="icon ion-social-instagram"></i></a><a href="https://twitter.com/SSanitario"><i class="icon ion-social-twitter"></i></a><a href="https://www.facebook.com/marco.ssi.56863"><i class="icon ion-social-facebook"></i></a><a href="https://www.linkedin.com/in/servizio-sanitario-29bb00190/"><i class="icon ion-social-linkedin"></i></a></div>
        <ul class="list-inline">
            <li class="list-inline-item"><a href="HomePage">Home</a></li>
            <li class="list-inline-item"><a href="Chi">About</a></li>
            <li class="list-inline-item"><a href="Terms">Condizioni d'utilizzo</a></li>
            <li class="list-inline-item"><a href="Privacy">Privacy</a></li>
        </ul>
        <p class="copyright">© Servizio Sanitario 2019. All Rights Reserved.</p>
    </footer>
</div>
    <script src="assetsHome/js/jquery.min.js"></script>
    <script src="assetsHome/bootstrap/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.8.2/js/lightbox.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/3.3.1/js/swiper.jquery.min.js"></script>
    <script src="assetsHome/js/Simple-Slider.js"></script>
</body>

</html>