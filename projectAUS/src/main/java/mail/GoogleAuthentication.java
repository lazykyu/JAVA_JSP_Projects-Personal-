package mail;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class GoogleAuthentication extends Authenticator{
	PasswordAuthentication passAuth;
	
	public GoogleAuthentication(){
		passAuth = new PasswordAuthentication("20110272deu", "alsrb15243");
	}
	
	public PasswordAuthentication getPasswordAuthentication(){
		return passAuth;
	}
}
