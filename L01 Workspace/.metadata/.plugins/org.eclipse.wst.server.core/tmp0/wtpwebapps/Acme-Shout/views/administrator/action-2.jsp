<%--
 * action-2.jsp
 *
 * Copyright (C) 2018 Universidad de Sevilla
 * 
 * The use of this project is hereby constrained to the conditions of the 
 * TDG Licence, a copy of which you may download from 
 * http://www.tdg-seville.info/License.html
 --%>
<head>
<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@taglib prefix="jstl"	uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<script type="text/javascript" src="scripts/Chart.js"></script>
</head>

<body>
<p><spring:message code="administrator.action.2" /></p>
<div class="chart-container" style="position: relative; height:10vh; width:20vw; responsive:true; responsiveAnimationDuration:5;">
<canvas id="myChart"></canvas>
<script>
var ctx = document.getElementById("myChart").getContext("2d");
var myChart = new Chart(ctx, {
    type: 'bar',
    data: {
        labels: ["<spring:message code="administrator.count.all.shouts" />", "<spring:message code="administrator.count.short.shouts" />", "<spring:message code="administrator.count.long.shouts" />"],
        datasets: [{
            label: 'Indicators',
            data: [<jstl:out value="${statistics.get('count.all.shouts')}" />,
                   <jstl:out value="${statistics.get('count.short.shouts')}" />,
                   <jstl:out value="${statistics.get('count.long.shouts')}" />],
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)'
            ],
            borderColor: [
                'rgba(255,99,132,1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)'
            ],
            borderWidth: 1
        }]
	    },
		options: {
		    scales: {
		        yAxes: [{
		            ticks: {
		                beginAtZero:true
		            }
		        }]
		    }
		}});
</script>
</div>
</body>