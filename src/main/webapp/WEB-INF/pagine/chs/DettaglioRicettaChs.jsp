<%-- 
    Document   : DettaglioRicettaChs
    Created on : 21-ago-2019, 16.45.04
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
                    <div class="card-header">
                        <h3 class="mb-0">Ricetta</h3>
                    </div>
                    <div class="card-body">
                        <h5 class="card-title mb-0">Prescrizione</h5>
                        <div class="table-responsive table-dettagli">
                            <table class="table">
                                <thead>
                                    <tr></tr>
                                </thead>
                                <tbody style="margin-bottom: -8px;">
                                    <tr>
                                        <td>Prescritto per</td>
                                        <td> ${requestScope.paziente.firstname} ${requestScope.paziente.lastname} </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 40%;">Prescritto da</td>
                                        <td style="width: 60%;">dott. ${requestScope.dottore.firstname} ${requestScope.dottore.lastname}</td>
                                    </tr>
                                    <tr>
                                        <td style="width: 40%;">Data di emissione</td>
                                        <td style="width: 60%;"> ${requestScope.visit.visdate} </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <h5 class="card-title mb-0">Dettagli ricetta</h5>
                        <div class="table-responsive table-dettagli">
                            <table class="table">
                                <thead>
                                    <tr></tr>
                                </thead>
                                <tbody style="margin-bottom: -8px;">
                                    <tr>
                                        <td style="width: 40%;">Farmaco prescritto</td>
                                        <td style="width: 60%;"> ${requestScope.prescription.name} </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 40%;">Quantità</td>
                                        <td style="width: 60%;"> ${requestScope.prescription.quantity} </td>
                                    </tr>
                                    <tr>
                                        <td>Ricetta attiva</td>
                                        <c:if test="${requestScope.prescription.active==1}">
                                            <td> Sì </td>
                                        </c:if>
                                        <c:if test="${requestScope.prescription.active==0}">
                                            <td> No </td>
                                        </c:if>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <h5 class="card-title mb-0">Evasione della ricetta</h5>
                        <div class="table-responsive table-dettagli" style="margin-bottom: -16px;">
                            <table class="table">
                                <thead>
                                    <tr></tr>
                                </thead>
                                <tbody style="margin-bottom: -8px;">
                                    <tr>
                                        <td style="width: 40%;">Data di evasione</td>
                                        <c:if test="${requestScope.prescription.active==0}">
                                            <td colspan="2" style="width: 60%;"> ${requestScope.prescription.madedate} </td>
                                        </c:if>
                                        <c:if test="${requestScope.prescription.active==1}">
                                            <td colspan="2" style="width: 60%;"><span style='font-style: italic'>Ricetta non evasa</span>  </td>
                                        </c:if>
                                    </tr>
                                    <tr>
                                        <td style="width: 40%;">Farmacia</td>
                                        <c:if test="${requestScope.prescription.active==0}">
                                            <td colspan="2" style="width: 60%;"> ${requestScope.farmacia.city} </td>
                                        </c:if>
                                        <c:if test="${requestScope.prescription.active==1}">
                                            <td colspan="2" style="width: 60%;"> <span style='font-style: italic'>Ricetta non evasa</span>  </td>
                                        </c:if>
                                    </tr>
                                    <tr>
                                        <td>Codice farmacia</td>
                                        <c:if test="${requestScope.prescription.active==0}">
                                            <td colspan="2" style="width: 60%;"> ${requestScope.farmacia.piva} </td>
                                        </c:if>
                                        <c:if test="${requestScope.prescription.active==1}">
                                            <td colspan="2" style="width: 60%;"> <span style='font-style: italic'>Ricetta non evasa</span>  </td>
                                        </c:if>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <a href="${pageContext.servletContext.contextPath}/restricted/chs/DettaglioRicettaChsToPDF?prescriptionId=${requestScope.prescription.id}"  target="blank">
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