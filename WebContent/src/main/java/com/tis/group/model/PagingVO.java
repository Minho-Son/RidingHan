package com.tis.group.model;

import lombok.Data;

@Data
public class PagingVO {
	//페이징 처리관련 프로퍼티 선언
		private int cpage=1; //현재 보여줄 페이지 번호( 디폴트 페이지 1)
		private int pageSize=10; //한페이지당 보여줄 목록개수
		private int totalCount; //총 게시글 수
		private int pageCount; //페이지 수
		
		//DB에서 레코드를 끊어 가져오기 위한 시작값과 끝값 프로퍼티
		private int start;
		private int end;
		
		//페이징 블록 처리를 위한 프로퍼티
		private int pagingBlock=5; // 한 블럭당 보여줄 페이지 개수
		private int prevBlock; // 이전
		private int nextBlock; // 이후
		
		//검색관련 프로퍼티
		private String findKeyword; //검색어
		
		public void init() {
			pageCount=(totalCount-1)/pageSize+1;
			if(cpage<1) {
				cpage=1;	//1페이지 디폴트
			}
			if(cpage>pageCount) {
				cpage=pageCount;	// 마지막 페이지로 설정
			}
			
			end=cpage*pageSize;
			start=end-(pageSize-1);
			
			//이전 5개, 이후5개 구하는 로직
			prevBlock=(cpage-1)/pagingBlock*pagingBlock;
			nextBlock=prevBlock +(pagingBlock+1);
		}
		
		public String getPageNavi(String myctx, String loc) {
			// myctx: 컨텍스트명
			// loc: 경로
			// qStr : query string (검색시 필요- 키워드)
			findKeyword=(findKeyword==null)?"":findKeyword;
			
			String qStr="?findKeyword="+findKeyword;
			//String 의 불변성 때문에 StringBuffer 또는 StringBuilder를 이용
			StringBuffer buf=new StringBuffer().append("<ul class='pagination pagination-sm'>");
			
			if(prevBlock>0) { //이전 5개
				buf.append("<li><a href='"+myctx+"/"+loc+qStr+"&cpage="+prevBlock+"'>");
				buf.append("Prev</a></li>");
			}
			for(int i=prevBlock +1 ; i<=nextBlock-1 && i<=pageCount; i++) {
				if(i==cpage) {
					buf.append("<li class='active'><a href='#'>").append(i+"</a></li>");
				}else {
					buf.append("<li><a href='"+myctx+"/"+loc+qStr+"&cpage="+i+"'>");
					buf.append(i+"</a></li>");
				}
			}
			if(nextBlock<=pageCount) { //이후 5개
				buf.append("<li><a href='"+myctx+"/"+loc+qStr+"&cpage="+nextBlock+"'>");
				buf.append("Next</a></li>");
			}
			
			buf.append("</ul>");
			String str=buf.toString();
			return str;
		}
		

}

