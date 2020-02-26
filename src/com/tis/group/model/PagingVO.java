package com.tis.group.model;

import lombok.Data;

@Data
public class PagingVO {
	//����¡ ó������ ������Ƽ ����
		private int cpage=1; //���� ������ ������ ��ȣ( ����Ʈ ������ 1)
		private int pageSize=10; //���������� ������ ��ϰ���
		private int totalCount; //�� �Խñ� ��
		private int pageCount; //������ ��
		
		//DB���� ���ڵ带 ���� �������� ���� ���۰��� ���� ������Ƽ
		private int start;
		private int end;
		
		//����¡ ��� ó���� ���� ������Ƽ
		private int pagingBlock=5; // �� ���� ������ ������ ����
		private int prevBlock; // ����
		private int nextBlock; // ����
		
		//�˻����� ������Ƽ
		private String findKeyword; //�˻���
		
		public void init() {
			pageCount=(totalCount-1)/pageSize+1;
			if(cpage<1) {
				cpage=1;	//1������ ����Ʈ
			}
			if(cpage>pageCount) {
				cpage=pageCount;	// ������ �������� ����
			}
			
			end=cpage*pageSize;
			start=end-(pageSize-1);
			
			//���� 5��, ����5�� ���ϴ� ����
			prevBlock=(cpage-1)/pagingBlock*pagingBlock;
			nextBlock=prevBlock +(pagingBlock+1);
		}
		
		public String getPageNavi(String myctx, String loc) {
			// myctx: ���ؽ�Ʈ��
			// loc: ���
			// qStr : query string (�˻��� �ʿ�- Ű����)
			findKeyword=(findKeyword==null)?"":findKeyword;
			
			String qStr="?findKeyword="+findKeyword;
			//String �� �Һ��� ������ StringBuffer �Ǵ� StringBuilder�� �̿�
			StringBuffer buf=new StringBuffer().append("<ul class='pagination pagination-sm'>");
			
			if(prevBlock>0) { //���� 5��
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
			if(nextBlock<=pageCount) { //���� 5��
				buf.append("<li><a href='"+myctx+"/"+loc+qStr+"&cpage="+nextBlock+"'>");
				buf.append("Next</a></li>");
			}
			
			buf.append("</ul>");
			String str=buf.toString();
			return str;
		}
		

}

