package com.tana.utilities;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.HashMap;
import java.util.Iterator;

import org.apache.log4j.Logger;
import org.json.JSONException;
import org.json.JSONObject;

public class JsonReader {
	private static Logger LOGGER = Logger.getLogger(JsonReader.class);

	public static String readUrl(String urlString) throws Exception {
		BufferedReader reader = null;
		try {
			URL url = new URL(urlString);
			reader = new BufferedReader(new InputStreamReader(url.openStream()));
			StringBuffer buffer = new StringBuffer();
			int read;
			char[] chars = new char[1024];
			while ((read = reader.read(chars)) != -1)
				buffer.append(chars, 0, read);

			return buffer.toString();
		} finally {
			if (reader != null)
				reader.close();
		}
	}

	public static HashMap<String, String> getCart(String accountId) {
		HashMap<String, String> prodInCart = new HashMap<>();
		try {
			prodInCart = jsonToMap(readUrl("http://localhost:8081/rest/getCart?userid=" + accountId));
		} catch (Exception e) {
			LOGGER.info("Parse error");
		}
		return prodInCart;

	}

	public static HashMap<String, String> jsonToMap(String t) {
		HashMap<String, String> map = new HashMap<String, String>();
		try {
			JSONObject jObject = new JSONObject(t);
			Iterator<?> keys = jObject.keys();
			while (keys.hasNext()) {
				String key = (String) keys.next();
				String value = jObject.getString(key);
				map.put(key, value);
			}
			return map;
		} catch (JSONException e) {
			return map;
		}
	}
}
