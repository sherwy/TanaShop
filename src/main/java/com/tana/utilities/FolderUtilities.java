package com.tana.utilities;

import java.io.File;

import org.apache.log4j.Logger;

public class FolderUtilities {

	public static Logger LOGGER = Logger.getLogger(FolderUtilities.class);

	public static void createFolderIfNotExist(String path) {
		LOGGER.info("Path file : "+path);
		File theDir = new File(path);
		if (!theDir.exists()) {
			LOGGER.info("Creating directory: " + theDir.getName());
			try {
				theDir.mkdir();
				LOGGER.info("Created directory");
			} catch (SecurityException se) {
				LOGGER.info("Cann't create the folder : " + path);
			}
		} else {
			LOGGER.info("Folder is already exist : " + path);
		}

	}
}
