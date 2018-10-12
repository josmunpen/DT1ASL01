L01 Workspace\Acme-Shout\src\main\java\controllers\CustomerController.java:
/*
 * CustomerController.java
 * 
 * Copyright (C) 2018 Universidad de Sevilla
 * 
 * The use of this project is hereby constrained to the conditions of the
 * TDG Licence, a copy of which you may download from
 * http://www.tdg-seville.info/License.html
 */

package controllers;

import java.util.Collection;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import services.ShoutService;
import domain.Shout;

@Controller
@RequestMapping("/customer")
public class CustomerController extends AbstractController {

	@Autowired
	private ShoutService	shoutService;


	// Constructors -----------------------------------------------------------

	public CustomerController() {
		super();
	}

	// Action-1 ---------------------------------------------------------------		

	@RequestMapping(value = "/action-1", method = RequestMethod.GET)
	public ModelAndView action1() {
		ModelAndView result;
		Collection<Shout> shouts;

		shouts = this.shoutService.findAll();

		result = new ModelAndView("customer/action-1");
		result.addObject("shouts", shouts);

		return result;
	}

	// Action-2 ---------------------------------------------------------------		

	@RequestMapping(value = "/action-2", method = RequestMethod.GET)
	public ModelAndView action2Get() {
		ModelAndView result;
		Shout shout;

		shout = this.shoutService.create();

		result = new ModelAndView("customer/action-2");
		result.addObject("shout", shout);

		return result;
	}

	@RequestMapping(value = "/action-2", method = RequestMethod.POST)
	public ModelAndView action2Post(@Valid final Shout shout, final BindingResult binding) {
		ModelAndView result;

		if (!binding.hasErrors()) {
			this.shoutService.save(shout);
			result = new ModelAndView("redirect:action-1.do");
		} else {
			result = new ModelAndView("customer/action-2");
			;
			result.addObject("shout", shout);
		}
		return result;
	}
}

L01 Workspace\Acme-Shout\src\main\java\domain\Shout.java:
package domain;

import javax.persistence.Entity;

import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.URL;

@Entity
public class Shout extends DomainEntity {

	private String	username;
	private String	link;
	private String	text;


	@NotBlank
	public String getUsername() {
		return this.username;
	}

	public void setUsername(final String username) {
		this.username = username;
	}

	@NotBlank
	@URL
	public String getLink() {
		return this.link;
	}

	public void setLink(final String link) {
		this.link = link;
	}

	@NotBlank
	public String getText() {
		return this.text;
	}

	public void setText(final String text) {
		this.text = text;
	}
}

L01 Workspace\Acme-Shout\src\main\java\repositories\ShoutRepository.java(Interfaz):

package repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import domain.Shout;

@Repository
@Transactional
public interface ShoutRepository extends JpaRepository<Shout, Integer> {

}

L01 Workspace\Acme-Shout\src\main\java\services\ShoutService.java:

package services;

import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import repositories.ShoutRepository;
import security.LoginService;
import security.UserAccount;
import domain.Shout;

@Service
@Transactional
public class ShoutService {

	@Autowired
	private ShoutRepository	shoutRepository;


	public Collection<Shout> findAll() {
		Collection<Shout> result;

		result = this.shoutRepository.findAll();

		return result;
	}

	public Shout create() {
		Shout result;
		UserAccount userAccount;
		String username;

		userAccount = LoginService.getPrincipal();
		username = userAccount.getUsername();

		result = new Shout();
		result.setUsername(username);
		result.setLink("");
		result.setText("");

		return result;
	}

	public void save(final Shout shout) {
		this.shoutRepository.save(shout);
	}

}

C:\Users\Usuario\Documents\GitHub\DT1ASL01\L01 Workspace\Acme-Shout\src\main\resources\PopulateDatabase.xml
<?xml version="1.0" encoding="UTF-8"?>

<!-- 
 * PopulateDatabase.xml
 *
 * Copyright (C) 2018 Universidad de Sevilla
 * 
 * The use of this project is hereby constrained to the conditions of the 
 * TDG Licence, a copy of which you may download from 
 * http://www.tdg-seville.info/License.html
 -->

<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="
		http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd
	">
	
	<!-- User accounts -->

	<bean id="userAccount1" class="security.UserAccount">
		<property name="username" value="admin" />
		<property name="password" value="21232f297a57a5a743894a0e4a801fc3" />
		<property name="authorities">
			<list>
				<bean class="security.Authority">
					<property name="authority" value="ADMIN" />
				</bean>
			</list>
		</property>
	</bean>

	<bean id="userAccount2" class="security.UserAccount">
		<property name="username" value="customer" />
		<property name="password" value="91ec1f9324753048c0096d036a694f86" />
		<property name="authorities">
			<list>
				<bean class="security.Authority">
					<property name="authority" value="CUSTOMER" />
				</bean>
			</list>
		</property>
	</bean>

	<bean id="userAccount3" class="security.UserAccount">
		<property name="username" value="super" />
		<property name="password" value="1b3231655cebb7a1f783eddf27d254ca" />
		<property name="authorities">
			<list>
				<bean class="security.Authority">
					<property name="authority" value="ADMIN" />
				</bean>
				<bean class="security.Authority">
					<property name="authority" value="CUSTOMER" />
				</bean>
			</list>
		</property>
	</bean>
	
	<!-- Other domain beans come here -->	
	<bean id = "shout1" class="domain.Shout">
	    <property name="username" value="John Doe" />
	    <property name="link" value="http://www.us.es" />
	    <property name="text" value="My alma mater" />
	</bean>
	
	<bean id = "shout2" class="domain.Shout">
	    <property name="username" value="Hedy ZD" />
	    <property name="link" value="http://www.academiasonsalseros.com" />
	    <property name="text" value="Learn salsa, bachata, and kizomba!" />
	</bean>
	
	<bean id = "shout3" class="domain.Shout">
	    <property name="username" value="María López" />
	    <property name="link" value="https://www.change.org/p/para-todos-no" />
	    <property name="text" value="End tampom tax now!" />
	</bean>	
	
	<bean id = "shout4" class="domain.Shout">
	    <property name="username" value="Jane Doe" />
	    <property name="link" value="https://www.change.org/p/Obama1" />
	    <property name="text" value="Obama rules!" />
	</bean>	
</beans>

C:\Users\Usuario\Documents\GitHub\DT1ASL01\L01 Workspace\Acme-Shout\src\main\webapp\views\customer\action-1.jsp

<%--
 * action-1.jsp
 *
 * Copyright (C) 2018 Universidad de Sevilla
 * 
 * The use of this project is hereby constrained to the conditions of the 
 * TDG Licence, a copy of which you may download from 
 * http://www.tdg-seville.info/License.html
 --%>

<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@taglib prefix="jstl"	uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>

<p><spring:message code="customer.action.1" /></p>

<display:table
	pagesize="5" name="shouts" id="row"
	requestURI="customer/action-1.do" >
	
	<display:column property="username"
	                titleKey="customer.username" />
	<display:column titleKey="customer.shout">
	    <strong>
	        <a href="${row.link}">
	            <jstl:out value="${row.link}" />
	          </a>
	    </strong>   <br/>
	    <jstl:out value="${row.text}" />
	 </display:column>
	 
</display:table>

C:\Users\Usuario\Documents\GitHub\DT1ASL01\L01 Workspace\Acme-Shout\src\main\webapp\views\customer\action-2.jsp
<%--
 * action-2.jsp
 *
 * Copyright (C) 2018 Universidad de Sevilla
 * 
 * The use of this project is hereby constrained to the conditions of the 
 * TDG Licence, a copy of which you may download from 
 * http://www.tdg-seville.info/License.html
 --%>

<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@taglib prefix="jstl"	uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>

<p><spring:message code="customer.action.2" /></p>

<form:form modelAttribute="shout">
	<form:hidden path="id" />
	<form:hidden path="version" />
	
	<form:label path="username"><spring:message code="customer.username" />:</form:label>
	<form:input path="username" />
	<form:errors path="username" />
	<br />
	
	<form:label path="link"> <spring:message code="customer.link" />: </form:label>
	<form:input path="link" />
	<form:errors path="link" />
	<br />
	
	<form:label path="text"> <spring:message code="customer.text" />: </form:label>
	<form:textarea path="text" />
	<form:errors path="text" />
	<br />
	
	<input type="submit" name="save" value="<spring:message code="customer.save" />" />
	
	<input type="button" name="cancel" value="<spring:message code="customer.cancel" />" 
	       onclick="javascript: relativeRedir('customer/action-1.do');" />

</form:form>

C:\Users\Usuario\Documents\GitHub\DT1ASL01\L01 Workspace\Acme-Shout\src\main\webapp\views\customer\messages.properties
# messages.properties
#
# Copyright (C) 2018 Universidad de Sevilla
# 
# The use of this project is hereby constrained to the conditions of the 
# TDG Licence, a copy of which you may download from 
# http://www.tdg-seville.info/License.html

customer.action.1	= This is the customer's action 1
customer.action.2	= This is the customer's action 2

customer.shout = Shout
customer.username = Username
customer.link = Link
customer.text = Text

customer.save = Save
customer.cancel = Cancel

C:\Users\Usuario\Documents\GitHub\DT1ASL01\L01 Workspace\Acme-Shout\src\main\webapp\views\customer\messages_es.properties
# messages_es.properties
#
# Copyright (C) 2018 Universidad de Sevilla
# 
# The use of this project is hereby constrained to the conditions of the 
# TDG Licence, a copy of which you may download from 
# http://www.tdg-seville.info/License.html

customer.action.1	= Esta es la acción 1 del cliente
customer.action.2	= Esta es la acción 2 del cliente

customer.shout = Grito
customer.username = Usuario
customer.link = Enlace
customer.text = Texto

customer.save = Salvar
customer.cancel = Cancelar