
package forms;

import javax.validation.constraints.Pattern;

public class Calculator {

	private double	x;
	private double	y;
	private String	operator;
	private double	result;


	public double getX() {
		return this.x;
	}
	public void setX(final double x) {
		this.x = x;
	}
	public double getY() {
		return this.y;
	}
	public void setY(final double y) {
		this.y = y;
	}

	@Pattern(regexp = "^[\\+\\-\\*\\/]$")
	public String getOperator() {
		return this.operator;
	}
	public void setOperator(final String operator) {
		this.operator = operator;
	}

	public double getResult() {
		return this.result;
	}
	public void setResult(final double result) {
		this.result = result;
	}

	public void compute() {
		switch (this.getOperator()) {
		case "+":
			this.setResult(this.getX() + this.getY());
			break;
		case "-":
			this.setResult(this.getX() - this.getY());
			break;
		case "*":
			this.setResult(this.getX() * this.getY());
			break;
		case "/":
			this.setResult(this.getX() / this.getY());
			break;

		}
	}

}
