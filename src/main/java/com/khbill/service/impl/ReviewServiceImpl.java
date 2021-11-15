package com.khbill.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.khbill.dao.face.ReviewCommentDao;
import com.khbill.dao.face.ReviewDao;
import com.khbill.dto.Ask;
import com.khbill.dto.Item;
import com.khbill.dto.Review;
import com.khbill.dto.ReviewComment;
import com.khbill.service.face.ReviewService;
import com.khbill.util.Paging;

@Service
public class ReviewServiceImpl implements ReviewService {
	
	private static final Logger logger = LoggerFactory.getLogger(ReviewServiceImpl.class);
	
	@Autowired ReviewDao reviewDao;
	@Autowired ReviewCommentDao reviewCommentDao;
	
	@Autowired private ServletContext context;
	

	@Override
	public Paging getPaging(Paging paramData) {
		
		//총 게시글 수 조회
		int totalCount = reviewDao.selectCntAll(paramData);
		
		//페이징 계산
		Paging paging = new Paging(totalCount, paramData.getCurPage());
		paging.setSearch(paramData.getSearch());
		
		return paging;
	}

	@Override
	public List<Review> getReviewList(Paging paging) {		
		return reviewDao.selectReviewList(paging);
	}

	@Override
	public HashMap<String, Object> getReviewDetail(Review review) {
		
		reviewDao.updatehit(review); //조회수 증가
		
		return reviewDao.selectReviewByReviewNo(review);
	}

	@Override
	public Item getReviewItem(int itemNo) {
		
		return reviewDao.selectItemByItemNo(itemNo);
	}

	@Override
	public com.khbill.dto.File getReviewFile(int fileNo) {
		
		return reviewDao.selectFileByFileNo(fileNo);
	}

	@Override
	public void setReviewCommentWrite(ReviewComment reviewComment) {	
		reviewCommentDao.insertReviewComment(reviewComment);
	}
	
	@Override
	public List<HashMap<String, Object>> getReviewComList(ReviewComment reviewComment) {
		return reviewCommentDao.selectReviewCommentByReview(reviewComment);
	}

	@Override
	public boolean deleteReviewComment(ReviewComment reviewComment) {
		
		reviewCommentDao.deleteReviewComment(reviewComment);
		
		if( reviewCommentDao.selectCountComment(reviewComment) > 0 ) {
			return false;
		} else {
			return true;
		}
	}

	@Override
	public void setReviewWrite(Review review, Item item, MultipartFile file) {
		
		//빈 파일
		if( file.getSize() <= 0 ) {
			return;
		}
		
		int userNo = review.getUserNo();
		int fileNo = reviewDao.getNextFileNo();
		int itemNo = reviewDao.getNextItemNo();
		int reviewNo = reviewDao.getNextReviewNo();
		
		
		//파일이 저장될 경로
		String storedPath = context.getRealPath("upload");
		
		File storedFolder = new File(storedPath);
		if( !storedFolder.exists() ) {
			storedFolder.mkdir();
		}
				
		//저장될 파일의 이름 생성하기
		String fileOrigin = file.getOriginalFilename();
		String fileStored = UUID.randomUUID().toString().split("-")[4] + fileOrigin;
				
		//저장할 파일 객체
		File dest = new File( storedPath, fileStored );
		
		try {
			file.transferTo(dest); //업로드 파일 저장
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		
		//--------------------------------------------------------
		com.khbill.dto.File reviewFile = new com.khbill.dto.File();
		
		reviewFile.setFileOrigin(fileOrigin);
		reviewFile.setFileStored(fileStored);
		reviewFile.setFileSize((int)file.getSize());
		reviewFile.setFileNo(fileNo);
		
		item.setUserNo(userNo);
		item.setFileNo(fileNo);
		item.setItemNo(itemNo);

		review.setItemNo(itemNo);
		review.setFileNo(fileNo);
		review.setReviewNo(reviewNo);
		
		reviewDao.insertFile(reviewFile);
		reviewDao.insertItem(item);
		reviewDao.insertReview(review);
		
		logger.info("review{}", review);
		logger.info("item{}", item);
		logger.info("reviewFile{}", reviewFile);
		
	}


}















