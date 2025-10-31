package com.kh.semi.error;

public class NoImageException extends RuntimeException{

	private static final long serialVersionUID = 1L;
	
	public NoImageException() {
		super();
	}

	public NoImageException(String message) {
		super(message);
	}
}
