<%-- 
    Document   : DettaglioVisitaSpeckChs
    Created on : 21-ago-2019, 16.45.43
    Author     : simmf
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="/WEB-INF/pagine/error.jsp"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Servizio Sanitario</title>
    <link rel="icon" href="../../assetsHome/img/favicon.ico">
    <link rel="shortcut icon" href="../../assetsHome/img/favicon.ico">
    <link rel="stylesheet" href="../../assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,700">
    <link rel="stylesheet" href="../../assets/css/styles.min.css">
</head>
<body style="background-color: #f4f4f4;">
    <jsp:include page="headerChs.jsp"/>
    <div class="container container-main">
        <div class="row">
            <div class="col-lg-10 col-xl-8 offset-lg-1 offset-xl-2" style="padding-right: 0;padding-left: 0;">
                <div class="card shadow-sm">
                    <div class="card-header" style="background-color: rgba(0,0,0,0.03);">
                        <h3 class="mb-0">${requestScope.listaVisite.name}</h3>
                    </div>
                    <div class="card-body">
                        <h5 class="card-title mb-0">Prescrizione</h5>
                        <div class="table-responsive table-dettagli" style="/*margin-bottom: -15px;*/">
                            <table class="table">
                                <thead>
                                    <tr></tr>
                                </thead>
                                <tbody style="margin-bottom: -8px;">
                                    <tr>
                                        <td style="width: 40%;">Prescritto a</td>
                                        <td style="width: 60%;">${requestScope.paziente.firstname} ${requestScope.paziente.lastname}</td>
                                    </tr>
                                    <tr>
                                        <td style="width: 40%;">Prescritto da</td>
                                        <td style="width: 60%;">${requestScope.prescrittore}</td>
                                    </tr>
                                    <tr>
                                        <td style="width: 40%;">Data prescrizione</td>
                                        <td style="width: 60%;">${requestScope.dataPrescrizione}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <h5 class="card-title mb-0">Informazioni sulla visita</h5>
                        <div class="table-responsive table-dettagli" style="/*margin-bottom: -15px;*/">
                            <table class="table">
                                <thead>
                                    <tr></tr>
                                </thead>
                                <tbody style="margin-bottom: -8px;">
                                    <tr>
                                        <td style="width: 40%;">Categoria esame</td>
                                        <td colspan="2">${requestScope.categoria.id} - ${requestScope.categoria.name}</td>
                                    </tr>
                                    <tr>
                                        <td>Note</td>
                                        <td colspan="2"> ${requestScope.note}</td>
                                    </tr>
                                    <tr>
                                        <td>Data di esecuzione</td> 
                                        <td colspan="2"> ${requestScope.dataEsecuzione} </td>
                                    </tr>
                                    <tr>
                                        <td>Medico</td> 
                                        <td colspan="2">  ${requestScope.specialista} </td> 
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <h5 class="card-title mb-0">Esito della visita</h5>
                        <div class="table-responsive table-dettagli" style="margin-bottom: -15px;">
                            <table class="table">
                                <thead>
                                    <tr></tr>
                                </thead>
                                <tbody style="margin-bottom: -8px;">
                                    <tr>
                                        <td style="width: 25%;">Esito</td>
                                        <c:if test="${requestScope.speckvisita.result == null}" > <td style="width: 65%;"> <span style='font-style: italic'>Esito non presente </span></td> </c:if>
                                        <c:if test="${requestScope.speckvisita.result != null}" > <td style="width: 65%;"> ${requestScope.speckvisita.result} </td> </c:if>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <a href="${pageContext.servletContext.contextPath}/restricted/chs/DettaglioVisitaSpeckChsToPDF?speckId=${requestScope.speckvisita.id}" target="blank">
                            <div class="media"><img src="../../assetsPazienti/img/pdf.png" class="mr-3 align-self-center" style="width: 40px;cursor: pointer;">
                                <div class="media-body">
                                    <p style="margin-bottom: 0;padding: 10px;">Download dei dettagli dell'esame in formato PDF</p>
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="../../assets/js/jquery.min.js"></script>
    <script src="../../assets/bootstrap/js/bootstrap.min.js"></script>
    <script src="../../assets/js/script.min.js"></script>
</body>

</html>