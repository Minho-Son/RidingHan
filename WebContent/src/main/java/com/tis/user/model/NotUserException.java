package com.tis.user.model;

public class NotUserException extends Exception{
	public NotUserException() {
		super("ȸ���� �ƴմϴ�");
	}
	public NotUserException(String msg) {
		super(msg);
	}
}
