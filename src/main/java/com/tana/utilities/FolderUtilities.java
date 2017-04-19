package com.tana.utilities;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.apache.log4j.Logger;
import org.springframework.web.multipart.MultipartFile;

public class FolderUtilities {

	public static Logger LOGGER = Logger.getLogger(FolderUtilities.class);

	public static void createFolderIfNotExist(String path) {
		LOGGER.info("Path file : " + path);
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

	public static String uploadFile(MultipartFile file, String pathFile,String key) {

		String fileName = null;
		try {
			FolderUtilities.createFolderIfNotExist(pathFile);

			if (!file.getOriginalFilename().equals("")) {
				byte[] bytes = file.getBytes();
				fileName = key + "." + file.getOriginalFilename().split("\\.")[1];
				LOGGER.info("File name : " + fileName);
				File checkFile = new File(pathFile + fileName);
				if (checkFile.exists()) {
					boolean result = Files.deleteIfExists(checkFile.toPath());
					if (result)
						LOGGER.info("Replace file : " + fileName);
				}
				Path path = Paths.get(pathFile + fileName);
				Files.write(path, bytes);
			}
		} catch (IOException e) {
			e.printStackTrace();
			return null;
		}

		return fileName;
	}

	public static String uploadFiles(MultipartFile[] files, String pathFile) {
		if (files != null && files.length > 0) {
			String fileName = null;
			String imgUrlDB = "";
			try {
				FolderUtilities.createFolderIfNotExist(pathFile);
				for (int i = 0; i < files.length; i++) {
					MultipartFile file = files[i];
					if (!file.getOriginalFilename().equals("")) {
						byte[] bytes = file.getBytes();
						fileName = i + "." + file.getOriginalFilename().split("\\.")[1];
						LOGGER.info("File name : " + fileName);
						if (i != 0) {
							imgUrlDB += ",";
						}
						imgUrlDB += fileName;
						File checkFile = new File(pathFile + fileName);
						if (checkFile.exists()) {
							boolean result = Files.deleteIfExists(checkFile.toPath());
							if (result)
								LOGGER.info("Replace file : " + fileName);
						}
						Path path = Paths.get(pathFile + fileName);
						Files.write(path, bytes);
					}
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
			return imgUrlDB;
		}
		return null;
	}
}
