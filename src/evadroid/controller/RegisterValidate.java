package evadroid.controller;
import java.util.regex.*;
import java.util.*;
public class RegisterValidate{
	public static boolean validateUsername(String username){
		//Pattern pattern = Pattern.compile("");
		return Pattern.matches("^[a-z0-9A-Z_]{4,32}$", username);
	}
	public static boolean validatePassword(String password){
		return password.length()>=6&&password.length()<64;
	}
	public static boolean validatePasswordMatch(String password, String passwordcfm){
		return password.equals(passwordcfm);
	}
}
