package com.tis.user.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.tis.user.mapper.UserMapper;
import com.tis.user.model.MemberVO;
import com.tis.user.model.NotUserException;

import lombok.extern.log4j.Log4j;

@Service(value="userServiceImpl")
@Log4j
public class UserServiceImpl implements UserService {

	@Inject
	private UserMapper userMapper;
	
	@Override
	public MemberVO memberChkByEmail(String user_id) {
		return this.userMapper.memberChkByEmail(user_id);
	}

	@Override
	public MemberVO memberChkByNick(String nick) {
		return this.userMapper.memberChkByNick(nick);
	}

	@Override
	public MemberVO isLoginOk(String user_id, String pwd) throws NotUserException {
		log.info("user_id=="+user_id);
		MemberVO mv=this.memberChkByEmail(user_id);
		if(mv==null) throw new NotUserException("존재하지 않는 아이디입니다");
		if(!mv.getPwd().contentEquals(pwd))
			throw new NotUserException("비밀번호가 일치하지 않아요");
		return mv;
		}

	@Override
	public int createMember(MemberVO vo) {
		return this.userMapper.createMember(vo);
	}

	@Override
	public int editMember(MemberVO vo) {		
		return this.userMapper.editMember(vo);
	}

}
