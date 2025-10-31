package com.kh.semi.error;

public class NeedClubJoinException extends RuntimeException{

	private static final long serialVersionUID = 1L;
	
	public NeedClubJoinException() {
		super();
	}

	public NeedClubJoinException(String message) {
		super(message);
	}
}
