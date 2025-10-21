package com.kh.semi.error;

public class TargetNotFoundException extends RuntimeException{

	private static final long serialVersionUID = 1L;
	
	public TargetNotFoundException() {
		super();
	}
	
	public TargetNotFoundException(String message) {
		super(message);
	}

}
