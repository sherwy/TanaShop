package com.tana.utilities;

import java.io.File;

import org.apache.log4j.Logger;

public class FolderUtilities {

	public static Logger LOGGER = Logger.getLogger(FolderUtilities.class);

	public static void createFolderIfNotExist(String path) {
		String[] pathSplit = path.split("/");
		for (int i = 0; i < pathSplit.length; i++) {
			path = pathSplit[i];
			File theDir = new File(path);
			if (!theDir.exists()) {
				LOGGER.info("Creating directory: " + theDir.getName());
				try {
					theDir.mkdir();
				} catch (SecurityException se) {
					LOGGER.info("Cann't create the folder : " + path);
				}
			} else {
				LOGGER.info("Folder is already exist : " + path);
			}
		}
	}
}
