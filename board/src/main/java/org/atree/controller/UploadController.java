package org.atree.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.atree.domain.BoardAttachDTO;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
public class UploadController {
	private boolean checkImageType(File file) {
		String contentType;
		try {
			contentType = Files.probeContentType(file.toPath());
			return contentType.startsWith("image");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		return str.replace("-", File.separator);
	}
	@GetMapping(value="/download",produces= {MediaType.APPLICATION_OCTET_STREAM_VALUE})
	@ResponseBody
	public ResponseEntity<byte[]> download(@RequestHeader("User-Agent")String userAgent,String fileName){
		
		ResponseEntity<byte[]> result=null;
		log.info(fileName);
		String fName=fileName.substring(0,fileName.lastIndexOf("_"));
		log.info("Fname: "+fName);
		String ext=fileName.substring(fileName.lastIndexOf("_")+1);
		String total=fName+"."+ext;
	
		
		int under=total.indexOf("_");
		String totalOrigin=total.substring(under+1);
		try {
			File target=new File("C:\\upload\\"+total);
			
			HttpHeaders header=new HttpHeaders();
			String downloadName=null;
			if(userAgent.contains("Trident")) {
				log.info("IE browser");
			downloadName=URLEncoder.encode(totalOrigin,"UTF-8").replaceAll("\\+"," ");
			}else if(userAgent.contains("Edge")) {
				log.info("edge browser");
				downloadName=URLEncoder.encode(totalOrigin,"UTF-8");
			}else {
				log.info("edge browser");
				downloadName=new String(totalOrigin.getBytes("UTF-8"),"ISO-8859-1");
			}
			log.info("downloadName:"+downloadName);
			
			
			header.add("Content-Disposition","attachment; filename="+downloadName);
			
			byte[] arr= FileCopyUtils.copyToByteArray(target);
			result=new ResponseEntity<>(arr,header,HttpStatus.OK);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
		}
		return result;
	}
//	@GetMapping(value="/download",produces=MediaType.APPLICATION_OCTET_STREAM_VALUE)
//	@ResponseBody
//	public ResponseEntity<Resource>downloadFile(@RequestHeader("User-Agent")String userAgent,String fileName){
//		Resource resource=new FileSystemResource("c:\\upload\\"+fileName);
//		log.info("fileName: "+fileName);
//		log.info(resource);
//		if(resource.exists()==false) {
//			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
//		}
//		String resourceName=resource.getFilename();
//		
//		String resourceOriginalName=resourceName.substring(resourceName.indexOf("_")+1);
//		
//		HttpHeaders headers=new HttpHeaders();
//		
//		
//			try {
//				String downloadName=null;
//				
//				if(userAgent.contains("Trident")) {
//					log.info("IE browser");
//				downloadName=URLEncoder.encode(resourceOriginalName,"UTF-8").replaceAll("\\+"," ");
//				}else if(userAgent.contains("Edge")) {
//					log.info("edge browser");
//					downloadName=URLEncoder.encode(resourceOriginalName,"UTF-8");
//				}else {
//					log.info("edge browser");
//					downloadName=new String(resourceOriginalName.getBytes("UTF-8"),"ISO-8859-1");
//				}
//				log.info("downloadName:"+downloadName);
//				
//				headers.add("Content-Dispositon", "attachment; filename="+downloadName);
//				
//			}catch (UnsupportedEncodingException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
//		
//		return new ResponseEntity<Resource>(resource,headers,HttpStatus.OK);
//	}
//	
	@PostMapping(value = "/upload", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachDTO>> upload(MultipartFile[] uploadFile) {
		
		List<BoardAttachDTO> list = new ArrayList<>();
		String uploadFolder = "C:\\upload";

		String uploadFolderPath = getFolder();
		// make folder --------
		File uploadPath = new File(uploadFolder, uploadFolderPath);

		if (uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		// make yyyy/MM/dd folder

		for (MultipartFile multipartFile : uploadFile) {
			

			BoardAttachDTO attachDTO = new BoardAttachDTO();
						
			String uploadFileName = multipartFile.getOriginalFilename();

			// IE has file path
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			log.info("only file name: " + uploadFileName);
			attachDTO.setFileName(uploadFileName);

			UUID uuid = UUID.randomUUID();

			uploadFileName = uuid.toString() + "_" + uploadFileName;

			try {
				File saveFile = new File(uploadPath, uploadFileName);
				multipartFile.transferTo(saveFile);


				attachDTO.setUuid(uuid.toString());
				attachDTO.setUploadPath(uploadFolderPath);

				// check image type file
				if (checkImageType(saveFile)) {

					attachDTO.setFileType(true);
				
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));

					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);

					thumbnail.close();
				}

				// add to List
				list.add(attachDTO);

			} catch (Exception e) {
				e.printStackTrace();
			}

		} // end for
		return new ResponseEntity<>(list, HttpStatus.OK);
		
	}
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName) {

		//log.info("fileName: " + fileName);

		File file = new File("c:\\upload\\" + fileName);

		//log.info("file: " + file);

		ResponseEntity<byte[]> result = null;

		try {
			HttpHeaders header = new HttpHeaders();

			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName,String type){
		File file;
		log.info("deleted----------------------------------------------------");
		log.info(fileName);
		try {
			log.info(URLDecoder.decode(fileName, "UTF-8"));
			file= new File("c:\\upload\\"+URLDecoder.decode(fileName, "UTF-8"));
			file.delete();
			if(type.equals("image")){
				String largeFileName=file.getAbsolutePath().replace("s_", "");
				file=new File(largeFileName);
				file.delete();
			}
		}catch(UnsupportedEncodingException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		return new ResponseEntity<String>("deleted",HttpStatus.OK);
		}
}
