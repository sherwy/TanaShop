package com.tana.utilities;

public class Calculation {
	
	public static String getAccountNumberWithCode(String bankAccountNumber){
		int codeIndex = 7;
		String accWithCode = "";
		for(int i=0 ; i<bankAccountNumber.length() ; i++){
			if(i < codeIndex)
				accWithCode += "x";
			else
				accWithCode += bankAccountNumber.charAt(i);
		}
		return accWithCode;
	}
}
