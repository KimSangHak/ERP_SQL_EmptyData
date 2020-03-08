-- --------------------------------------------------------
-- 호스트:                          yuhannci.iptime.org
-- 서버 버전:                        10.1.20-MariaDB - MariaDB Server
-- 서버 OS:                        Linux
-- HeidiSQL 버전:                  9.4.0.5125
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- yuhan_erp_2 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `yuhan_erp_2` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `yuhan_erp_2`;

-- 테이블 yuhan_erp_2.android_token 구조 내보내기
CREATE TABLE IF NOT EXISTS `android_token` (
  `token` varchar(255) NOT NULL COMMENT 'DeviceToekn',
  `userId` char(5) DEFAULT NULL COMMENT 'userId',
  `dept` char(2) DEFAULT NULL COMMENT '부서',
  `isManager` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '팀장여부',
  `isFactory` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '공장장여부',
  `isDelector` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '재무이사여부',
  `isCEO` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '대표이사여부',
  `isPQ` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '구매부여부',
  PRIMARY KEY (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='안드로이드토큰';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.bankKind 구조 내보내기
CREATE TABLE IF NOT EXISTS `bankKind` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL COMMENT '은행명',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='은행';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.billing_after_data 구조 내보내기
CREATE TABLE IF NOT EXISTS `billing_after_data` (
  `id` varchar(5) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='결제 기한';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.billing_day_data 구조 내보내기
CREATE TABLE IF NOT EXISTS `billing_day_data` (
  `id` varchar(5) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='결제일 목록';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.bulletin 구조 내보내기
CREATE TABLE IF NOT EXISTS `bulletin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` char(5) NOT NULL COMMENT '게시글 작성자',
  `when_created` datetime NOT NULL COMMENT '작성 날짜',
  `title` varchar(128) NOT NULL COMMENT '제목',
  `body` text NOT NULL COMMENT '본문',
  `deleted` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '삭제 여부',
  PRIMARY KEY (`id`),
  KEY `FK_bulletin_user` (`user_id`),
  CONSTRAINT `FK_bulletin_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='게시판';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.calendar_data 구조 내보내기
CREATE TABLE IF NOT EXISTS `calendar_data` (
  `when` date NOT NULL,
  `label` varchar(128) NOT NULL,
  PRIMARY KEY (`when`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='메인 캘린더에 표시할 추가 정보';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.concept_job_order 구조 내보내기
CREATE TABLE IF NOT EXISTS `concept_job_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_type` enum('JOB','JIG') NOT NULL COMMENT '작업 지시 유형(컨셉, 치공구 컨셉)',
  `order_date` datetime NOT NULL COMMENT '등록일',
  `customer_id` char(2) NOT NULL COMMENT '고객사ID',
  `order_no_base` char(5) DEFAULT NULL COMMENT 'Order No 앞부분(NULL 가능)',
  `order_no_extra` varchar(45) DEFAULT NULL COMMENT 'Order-No 뒷부분',
  `deleted` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '삭제 여부(Y/N)',
  `device` varchar(64) NOT NULL COMMENT 'Device',
  `concept_finish_date` date DEFAULT NULL COMMENT '장비/치공구 컨셉 완료일',
  `business_user_id` char(5) NOT NULL COMMENT '영업 담당',
  `design_user_id` char(5) NOT NULL COMMENT '설계 담당',
  `customer_user` varchar(30) NOT NULL COMMENT '고객사 담당자',
  `note` text COMMENT '비고(진행 정보?)',
  `quantity` int(11) DEFAULT NULL COMMENT '수량(치공구를 제외한 유형에서만 사용)',
  `internal_unit_price` int(11) DEFAULT NULL COMMENT '내부 단가',
  `estimated_price` int(11) DEFAULT NULL COMMENT '견적 금액',
  `negotiated_price` int(11) DEFAULT NULL COMMENT '네고 가격',
  `internal_unit_price_shared_date` date DEFAULT NULL COMMENT '내부단가 공유일',
  `internal_price_file_no` bigint(20) DEFAULT NULL COMMENT '내부 단가 파일 번호',
  `concept_file_no` bigint(20) DEFAULT NULL COMMENT '컨셉 도면 파일 번호',
  `current_stage` enum('R','A','B','C','D','F') NOT NULL DEFAULT 'R' COMMENT '컨셉진행(R), 단가계산(A), 고객사승인대기(B),견적서작성(C), 견적서송부(D),작업지시&발주(F)',
  `job_order_id` bigint(20) DEFAULT NULL COMMENT '작업 지시 진행된 경우 연관된 ID (job_order 테이블의 id)',
  `last_modified_when` datetime DEFAULT NULL COMMENT '마지막 수정 시각',
  `last_modified_user_id` char(5) DEFAULT NULL COMMENT '마지막 수정한 사람',
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_no` (`order_no_base`,`order_no_extra`),
  KEY `partner_id` (`customer_id`),
  KEY `current_stage` (`current_stage`),
  KEY `FK_concept_job_order_user` (`business_user_id`),
  KEY `FK_concept_job_order_user_2` (`design_user_id`),
  KEY `FK_concept_job_order_user_3` (`last_modified_user_id`),
  KEY `FK_concept_job_order_job_order` (`job_order_id`),
  KEY `deleted` (`deleted`),
  CONSTRAINT `FK_concept_job_order_job_order` FOREIGN KEY (`job_order_id`) REFERENCES `job_order` (`id`),
  CONSTRAINT `FK_concept_job_order_partner` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  CONSTRAINT `FK_concept_job_order_user` FOREIGN KEY (`business_user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_concept_job_order_user_2` FOREIGN KEY (`design_user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_concept_job_order_user_3` FOREIGN KEY (`last_modified_user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='설비 컨셉, 치공구 컨셉 작업 원장 ';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.config_list 구조 내보내기
CREATE TABLE IF NOT EXISTS `config_list` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `view_sort` int(11) NOT NULL COMMENT '기계번호',
  `val` varchar(256) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COMMENT='콤보 박스에 뿌려지는 리스트 저장 테이블';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.customer 구조 내보내기
CREATE TABLE IF NOT EXISTS `customer` (
  `id` char(2) NOT NULL COMMENT '업체코드',
  `name` varchar(64) NOT NULL COMMENT '업체명',
  `region` varchar(50) DEFAULT NULL COMMENT '업체지역',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='고객사 테이블 (매출 거래처)';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.dayoff 구조 내보내기
CREATE TABLE IF NOT EXISTS `dayoff` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` char(5) DEFAULT NULL COMMENT '신청한 직원 ID',
  `day_off_name` varchar(128) DEFAULT NULL COMMENT '''회사일정(NOTICE)'' 인 경우 표시할 레이블',
  `day_off_type` enum('AM','PM','OFF','DAY','HOLIDAY') NOT NULL COMMENT '연차 사용 유형. 오전반차(''AM''), 오후반차(''PM''), 휴가(''DAY''), 휴무(''OFF''),회사일정(''NOTICE'')',
  `when_day_off` date NOT NULL COMMENT '연차 사용 날짜',
  `reg_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '최초 등록 일자',
  PRIMARY KEY (`id`),
  KEY `FK_annual_holiday_user` (`user_id`),
  CONSTRAINT `FK_annual_holiday_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='연차/휴무 관리 테이블\r\n- 2018-04-03 :: ''회사일정'' 유형 추가';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.dept_data 구조 내보내기
CREATE TABLE IF NOT EXISTS `dept_data` (
  `id` char(2) NOT NULL,
  `dept_name` varchar(50) NOT NULL COMMENT '부서명',
  `manager_id` char(5) NOT NULL COMMENT '부서장ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='부서 관리 테이블';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.design_history 구조 내보내기
CREATE TABLE IF NOT EXISTS `design_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `drawing_id` bigint(20) NOT NULL,
  `kind` enum('A','B','C','D','E','F','N') NOT NULL COMMENT '출도A, 가공B, 검사C, 입고D, 인계E, 재가공F, 추가출도N',
  `reg_date` date NOT NULL,
  `reg_usr` char(5) NOT NULL COMMENT '처리한 사용자',
  `description` varchar(512) NOT NULL COMMENT '설명',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8 COMMENT='설계 도면 history';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 함수 yuhan_erp_2.FN_FormatOrderNoExtra 구조 내보내기
DELIMITER //
CREATE DEFINER=`yuhanerp_web_user_1`@`%` FUNCTION `FN_FormatOrderNoExtra`(
	`OrgOrderNoExtra` VARCHAR(50)
) RETURNS varchar(100) CHARSET utf8
    NO SQL
    COMMENT '주문번호의 Extra 항목을 표준화'
BEGIN

	
	

	if OrgOrderNoExtra like 'AS%' then
		return 'AS-' + substring(OrgOrderNoExtra,3,1) + '-' + substring(OrgOrderNoExtra, 4);
	else
		return OrgOrderNoExtra;
	end if;
END//
DELIMITER ;

-- 함수 yuhan_erp_2.FN_GetBusinessDepartmentCode 구조 내보내기
DELIMITER //
CREATE DEFINER=`yuhanerp_web_user_1`@`%` FUNCTION `FN_GetBusinessDepartmentCode`() RETURNS char(2) CHARSET utf8
    NO SQL
    DETERMINISTIC
    SQL SECURITY INVOKER
    COMMENT '영업부 부서 코드'
BEGIN
	
	
	return 'TS';
END//
DELIMITER ;

-- 함수 yuhan_erp_2.FN_GetCustomerName 구조 내보내기
DELIMITER //
CREATE DEFINER=`root`@`localhost` FUNCTION `FN_GetCustomerName`(
	`partner_id` CHAR(2)

) RETURNS varchar(64) CHARSET utf8
    NO SQL
    COMMENT 'user name 출력'
BEGIN
	return (select ifnull(name, '') from customer where id=partner_id);

END//
DELIMITER ;

-- 함수 yuhan_erp_2.FN_GetCustomerNameOfDesignDrawing 구조 내보내기
DELIMITER //
CREATE DEFINER=`yuhanerp_web_us`@`%` FUNCTION `FN_GetCustomerNameOfDesignDrawing`(
	`DesignDrawingId` BIGINT

) RETURNS varchar(100) CHARSET utf8
    READS SQL DATA
    DETERMINISTIC
    COMMENT '해당 도면의 고객사 이름'
BEGIN
	
	return (SELECT name FROM customer WHERE customer.id = 
					(SELECT customer_id FROM job_order WHERE id = 
						(SELECT order_id FROM job_design_drawing WHERE id = DesignDrawingId )));
END//
DELIMITER ;

-- 함수 yuhan_erp_2.FN_GetDesignDepartmentCode 구조 내보내기
DELIMITER //
CREATE DEFINER=`yuhanerp_web_user_1`@`%` FUNCTION `FN_GetDesignDepartmentCode`() RETURNS char(2) CHARSET utf8
    NO SQL
    DETERMINISTIC
    SQL SECURITY INVOKER
BEGIN
	return 'TC';
END//
DELIMITER ;

-- 함수 yuhan_erp_2.FN_GetDisplayDrawingNo 구조 내보내기
DELIMITER //
CREATE DEFINER=`yuhanerp_web_user_1`@`%` FUNCTION `FN_GetDisplayDrawingNo`(
	`orderType` VARCHAR(50),
	`orderNo` VARCHAR(50),
	`orderNoExtra` VARCHAR(50),
	`drawingNo` VARCHAR(50)

) RETURNS varchar(60) CHARSET utf8
    NO SQL
    COMMENT '도면변호를 화면 표시용으로 변환시킴'
BEGIN

	if orderType = 'JOB' then
		
		return if( (orderNoExtra is null or orderNoExtra = '')
					, concat(orderNo, '-', drawingNo)
					, concat(orderNo, '-', orderNoExtra, '-', drawingNo));
	else
		
		return if( (orderNoExtra is null or orderNoExtra = '')
					, concat(left(orderNo,2), '-', right(orderNo, 3), '-', drawingNo)
					, concat(left(orderNo,2), '-', right(orderNo, 3), '-', orderNoExtra, '-', drawingNo) );
	end if;

END//
DELIMITER ;

-- 함수 yuhan_erp_2.FN_GetDisplayOrderNo 구조 내보내기
DELIMITER //
CREATE DEFINER=`yuhanerp_web_user_1`@`%` FUNCTION `FN_GetDisplayOrderNo`(
	`orderType` VARCHAR(50),
	`orderNo` VARCHAR(50),
	`orderNoExtra` VARCHAR(50)





) RETURNS varchar(40) CHARSET utf8
    NO SQL
    COMMENT 'Order-No 를 화면 표시용으로 변환시킴'
BEGIN
	if orderNo is null then
		return '(없음)';
	end if;
	
	if orderType = 'JOB' then
		
		return if( (orderNoExtra is null or orderNoExtra = '')
					, orderNo
					, concat(orderNo, '-', orderNoExtra));
	else
		
		return if( (orderNoExtra is null or orderNoExtra = '')
					, concat(left(orderNo,2), '-', right(orderNo, 3))
					, concat(left(orderNo,2), '-', right(orderNo, 3), '-', orderNoExtra) );
	end if;

END//
DELIMITER ;

-- 함수 yuhan_erp_2.FN_GetDisplayOutsourcingOrderNo 구조 내보내기
DELIMITER //
CREATE DEFINER=`yuhanerp_web_us`@`%` FUNCTION `FN_GetDisplayOutsourcingOrderNo`(
	`outsourcingPartnerId` VARCHAR(100),
	`requestType` varchar(100),
	`id` varchar(100)



) RETURNS varchar(50) CHARSET utf8
    DETERMINISTIC
    COMMENT '외주 발주번호를 화면 표기 형태로 만들어준다'
BEGIN


	return concat( (case requestType when 'P' then '가' when 'C' then '후' else requestType end) ,'-' , outsourcingPartnerId, '-', id);
END//
DELIMITER ;

-- 함수 yuhan_erp_2.FN_GetDrawingCurrentStatus 구조 내보내기
DELIMITER //
CREATE DEFINER=`yuhanerp_web_us`@`%` FUNCTION `FN_GetDrawingCurrentStatus`(
	`type_code` char(1)
) RETURNS varchar(50) CHARSET utf8
    NO SQL
    COMMENT 'Table별 Type 출력'
BEGIN
	declare getStatus varchar(50);

 	-- 작업완료 상황, 설계A, 생관B, 가공C, 검사D, 조립E, 배선F, 후처리G
    CASE type_code
       WHEN 'A' THEN
          SET getStatus = '설계';
       WHEN 'B' THEN
          SET getStatus = '생관';
       WHEN 'C' THEN
          SET getStatus = '가공';
       WHEN 'D' THEN
          SET getStatus = '검사';
       WHEN 'E' THEN
          SET getStatus = '조립';
       WHEN 'F' THEN
          SET getStatus = '배선';
       WHEN 'G' THEN
          SET getStatus = '후처리';
       ELSE
          SET getStatus = 'NONE';
    END CASE;

	return getStatus;
END//
DELIMITER ;

-- 함수 yuhan_erp_2.FN_GetManagerDepartmentCode 구조 내보내기
DELIMITER //
CREATE DEFINER=`yuhanerp_web_us`@`%` FUNCTION `FN_GetManagerDepartmentCode`(

) RETURNS char(2) CHARSET utf8
    NO SQL
    COMMENT 'Table별 Type 출력'
BEGIN
	return 'MM';
END//
DELIMITER ;

-- 함수 yuhan_erp_2.FN_GetOutSourceName 구조 내보내기
DELIMITER //
CREATE DEFINER=`yuhanerp_web_us`@`%` FUNCTION `FN_GetOutSourceName`(
	`work_position` char(1),
	`outsourcing_partner_id` varchar(5)
) RETURNS varchar(50) CHARSET utf8
    NO SQL
    COMMENT '외주업체 명 또는 사내 가공'
BEGIN
	declare getName varchar(50);

	IF `work_position` = 'I' THEN
		SET getName = '사내가공';
	ELSEIF `work_position` = 'S' THEN
		SET getName = '표준품';
	ELSEIF `work_position` = 'D' THEN
		SET getName = '표준품 가공';
	ELSE
		select ifnull(partner_name, '') into getName from job_partner where id=outsourcing_partner_id;
	END IF;
	return getName;
END//
DELIMITER ;

-- 함수 yuhan_erp_2.FN_GetPartnerName 구조 내보내기
DELIMITER //
CREATE DEFINER=`yuhanerp_web_us`@`%` FUNCTION `FN_GetPartnerName`(
	`outsourcingPartnerId` VARCHAR(100)



) RETURNS varchar(10) CHARSET utf8
    DETERMINISTIC
    COMMENT '도면의 상태'
BEGIN

	return (select partner_name from job_partner where id = outsourcingPartnerId);
END//
DELIMITER ;

-- 함수 yuhan_erp_2.FN_GetTypeName 구조 내보내기
DELIMITER //
CREATE DEFINER=`yuhanerp_web_us`@`%` FUNCTION `FN_GetTypeName`(
	`table_name` varchar(20),
	`type_code` char(1)
) RETURNS varchar(50) CHARSET utf8
    NO SQL
    COMMENT 'Table별 Type 출력'
BEGIN
	declare getStatus varchar(50);

	IF `table_name` = 'job_mct_history' THEN
	 	-- 작업완료 상황, R:대기, Q:완료, C:취소, I:작업중, H:홀딩, S:일시중지
	    CASE type_code
	       WHEN 'R' THEN
	          SET getStatus = '작업대기';
	       WHEN 'F' THEN
	          SET getStatus = '완료';
	       WHEN 'C' THEN
	          SET getStatus = '취소';
	       WHEN 'I' THEN
	          SET getStatus = '작업중';
	       WHEN 'H' THEN
	          SET getStatus = '홀딩';
	       WHEN 'S' THEN
	          SET getStatus = '일시중지';
	       ELSE
	          SET getStatus = '도면대기';
	    END CASE;
	ELSEIF `table_name` = 'job_purchase' THEN
	 	-- 'R' - 구매등록 상태, 'E' - 견적요청중, 'P' - 구매요청, 'F' - 입고완료, 'O' - 불출완료
	    CASE type_code
	       WHEN 'R' THEN
	          SET getStatus = '구매등록';
	       WHEN 'E' THEN
	          SET getStatus = '견적요청중';
	       WHEN 'P' THEN
	          SET getStatus = '발주요청';
	       WHEN 'F' THEN
	          SET getStatus = '입고완료';
	       WHEN 'O' THEN
	          SET getStatus = '불출완료';
	       ELSE
	          SET getStatus = 'NONE';
	    END CASE;
	ELSEIF `table_name` = 'JobSetupList' THEN
	 	-- 진행 상태-R:대기, F:완료, C:취소, I:사내작업중, O:고객사작업중, H:홀딩, S:중지
	    CASE type_code
	       WHEN 'R' THEN
	          SET getStatus = '대기';
	       WHEN 'I' THEN
	          SET getStatus = '사내작업중';
	       WHEN 'O' THEN
	          SET getStatus = '고객사작업중';
	       WHEN 'H' THEN
	          SET getStatus = '홀딩';
	       WHEN 'S' THEN
	          SET getStatus = '중지';
	       WHEN 'F' THEN
	          SET getStatus = '완료';
	       WHEN 'C' THEN
	          SET getStatus = '취소';
	       ELSE
	          SET getStatus = 'NONE';
	    END CASE;
	ELSE
	    CASE type_code
	       WHEN 'R' THEN
	          SET getStatus = '대기';
	       WHEN 'F' THEN
	          SET getStatus = '완료';
	       WHEN 'C' THEN
	          SET getStatus = '취소';
	       WHEN 'I' THEN
	          SET getStatus = '작업중';
	       WHEN 'H' THEN
	          SET getStatus = '홀딩';
	       WHEN 'S' THEN
	          SET getStatus = '일시중지';
	       ELSE
	          SET getStatus = 'NONE';
	    END CASE;
	END IF;
	return getStatus;
END//
DELIMITER ;

-- 함수 yuhan_erp_2.FN_GetUserName 구조 내보내기
DELIMITER //
CREATE DEFINER=`root`@`localhost` FUNCTION `FN_GetUserName`(
	`user_id` CHAR(5)

) RETURNS varchar(20) CHARSET utf8
    NO SQL
    COMMENT 'user name 출력'
BEGIN
	declare getName varchar(20);

	select ifnull(name, '') into getName from user where id=user_id;

	return getName;
END//
DELIMITER ;

-- 함수 yuhan_erp_2.FN_MakeCode 구조 내보내기
DELIMITER //
CREATE DEFINER=`yuhanerp_web_user_1`@`%` FUNCTION `FN_MakeCode`(
	`SectionId` CHAR(3),
	`PartnerId` CHAR(5)
) RETURNS char(22) CHARSET utf8
BEGIN
	return concat(yuhanerpSectionId, PartnerId, DATE_FORMAT(now(),'%Y%m%d%H%i%s%f'));
END//
DELIMITER ;

-- 함수 yuhan_erp_2.FN_MakeNextOrderNo 구조 내보내기
DELIMITER //
CREATE DEFINER=`yuhanerp_web_user_1`@`%` FUNCTION `FN_MakeNextOrderNo`(
	`target_partner_id` CHAR(2)









) RETURNS char(3) CHARSET utf8
    READS SQL DATA
    SQL SECURITY INVOKER
BEGIN

	

	declare ThisValue bigint;
	declare installSequence char(3);
	
	
	if not exists (select * from partner_sequence_data where partner_sequence_data.partner_id = target_partner_id) then
 		insert into partner_sequence_data (partner_id, next_value) values(target_partner_id, 1);
 	end if;

	select 
			next_value into ThisValue
		from partner_sequence_data
		where partner_id = target_partner_id;

	
	
	
	
	
	
	
	
	
	if ThisValue >= 3500 then
		signal SQLSTATE '45000' SET MESSAGE_TEXT = 'No more order-no available';
	end if;
	
	if ThisValue >= 1000 then
		select concat( char( 65 + ((ThisValue - 1000) / 100)), lpad((ThisValue - 1000) % 100, 2, '0') ) into installSequence ;
	else
		select lpad( ThisValue, 3, '0') into installSequence;
	end if;
	
	return installSequence;
END//
DELIMITER ;

-- 함수 yuhan_erp_2.FN_MakeNextOrderNoBase 구조 내보내기
DELIMITER //
CREATE DEFINER=`yuhanerp_web_user_1`@`%` FUNCTION `FN_MakeNextOrderNoBase`(
	`target_partner_id` CHAR(2)
,
	`isConcept` ENUM('Y','N')


) RETURNS char(3) CHARSET utf8
    READS SQL DATA
    SQL SECURITY INVOKER
BEGIN

	


	declare ThisValue bigint;
	declare installSequence char(3);
	declare lastSequence char(3);
		
	if isConcept = 'Y' then
		select 
			max(substring(order_no_base, 3,3)) into lastSequence
		from concept_job_order
		where customer_id = target_partner_id;
	else
		select 
			max(substring(order_no_base, 3,3)) into lastSequence
		from job_order
		where customer_id = target_partner_id;	
	end if;
	
	if lastSequence is null then
		set lastSequence = '000';
	end if;
	
	if substring(lastSequence, 1, 1) between '0' and '9' then
		set ThisValue = cast(lastSequence as unsigned);
	else
		set ThisValue = (ascii(substring(lastSequence, 1,1)) - 65) * 100 + 1000 + cast( substring(lastSequence, 2, 2) as unsigned );
	end if;
	
	set ThisValue = ThisValue + 1;

	
	
	
	
	
	
	
	
	
	if ThisValue >= 3500 then
		signal SQLSTATE '45000' SET MESSAGE_TEXT = 'No more order-no available';
	end if;
	
	if ThisValue >= 1000 then
		select concat( char( 65 + ((ThisValue - 1000) / 100)), lpad((ThisValue - 1000) % 100, 2, '0') ) into installSequence ;
	else
		select lpad( ThisValue, 3, '0') into installSequence;
	end if;
	
	return installSequence;
END//
DELIMITER ;

-- 함수 yuhan_erp_2.FN_MakeNextOrderNoBase2 구조 내보내기
DELIMITER //
CREATE DEFINER=`yuhanerp_web_user_1`@`%` FUNCTION `FN_MakeNextOrderNoBase2`(
	`targetpartnerid` CHAR(2),
	`isConcept` ENUM('Y','N'),
	`ordertype` ENUM('JOB', 'JIG')

) RETURNS char(3) CHARSET utf8
    READS SQL DATA
    SQL SECURITY INVOKER
BEGIN
	declare ThisValue bigint;
	declare installSequence char(3);
	declare lastSequence char(3);
		
	if isConcept = 'Y' then
		select 
			max(substring(order_no_base, 3,3)) into lastSequence
		from concept_job_order
		where customer_id = targetpartnerid and order_type = ordertype;
	else
		select 
			max(substring(order_no_base, 3,3)) into lastSequence
		from job_order
		where customer_id = targetpartnerid and order_type = ordertype;	
	end if;
	
	if lastSequence is null then
		set lastSequence = '000';
	end if;
	
	if substring(lastSequence, 1, 1) between '0' and '9' then
		set ThisValue = cast(lastSequence as unsigned);
	else
		set ThisValue = (ascii(substring(lastSequence, 1,1)) - 65) * 100 + 1000 + cast( substring(lastSequence, 2, 2) as unsigned );
	end if;
	
	set ThisValue = ThisValue + 1;

	
	
	
	
	
	
	
	
	
	if ThisValue >= 3500 then
		signal SQLSTATE '45000' SET MESSAGE_TEXT = 'No more order-no available';
	end if;
	
	if ThisValue >= 1000 then
		select concat( char( 65 + ((ThisValue - 1000) / 100)), lpad((ThisValue - 1000) % 100, 2, '0') ) into installSequence ;
	else
		select lpad( ThisValue, 3, '0') into installSequence;
	end if;
	
	return installSequence;
END//
DELIMITER ;

-- 함수 yuhan_erp_2.FN_MakeTransactionId 구조 내보내기
DELIMITER //
CREATE DEFINER=`yuhanerp_web_user_1`@`%` FUNCTION `FN_MakeTransactionId`(
	`SectionId` CHAR(1),
	`PartnerId` CHAR(5)



) RETURNS varchar(26) CHARSET utf8
BEGIN
	return concat( ucase(ifnull(SectionId, '')), (if(SectionId is not null, '-', '' )), ucase(ifnull(PartnerId, '')), (if(PartnerId is not null, '-', '' )),substring(DATE_FORMAT(now(3),'%Y%m%d%H%i%s%f'), 1, 16) );
END//
DELIMITER ;

-- 테이블 yuhan_erp_2.isuue_round_robin 구조 내보내기
CREATE TABLE IF NOT EXISTS `isuue_round_robin` (
  `robin_request_id` char(20) NOT NULL COMMENT '품의서발주코드',
  `round_robin_id` bigint(20) NOT NULL COMMENT 'round_robin_ID',
  `job_order_id` bigint(20) DEFAULT NULL COMMENT '구매 대상의 작업 지시 번호',
  `partner_id` char(5) NOT NULL COMMENT '발주업체 ID',
  `model_no` varchar(128) NOT NULL COMMENT '모델NO',
  `maker` varchar(128) NOT NULL,
  `reg_date` datetime NOT NULL COMMENT '등록날짜',
  `receive_date` date NOT NULL COMMENT '납기일',
  `reg_user` char(5) NOT NULL COMMENT '발주등록자',
  `issue_price` int(11) DEFAULT NULL COMMENT '발주가',
  `quantity` int(11) NOT NULL COMMENT '발주수량',
  `issue_type` enum('B','C','H') NOT NULL DEFAULT 'B' COMMENT '발주 타입 ''B'' - 일반업체발주, ''C'' - 직접구매카드결제, ''H'' - 직접구매간이영수증',
  `cancle` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '발주취소 여부',
  `cancle_reason` varchar(256) DEFAULT NULL COMMENT '발주취소 사유',
  `statement` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '거래명세표 등록 여부',
  PRIMARY KEY (`robin_request_id`,`round_robin_id`),
  KEY `FK_isuue_robin_job_order` (`job_order_id`),
  KEY `FK_isuue_robin_round_robin` (`round_robin_id`),
  KEY `FK_isuue_robin_job_partner` (`partner_id`),
  CONSTRAINT `FK_isuue_robin_job_order` FOREIGN KEY (`job_order_id`) REFERENCES `job_order` (`id`),
  CONSTRAINT `FK_isuue_robin_job_partner` FOREIGN KEY (`partner_id`) REFERENCES `job_partner` (`id`),
  CONSTRAINT `FK_isuue_robin_round_robin` FOREIGN KEY (`round_robin_id`) REFERENCES `round_robin` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='구매품의서 발주 원장';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.job_delivery 구조 내보내기
CREATE TABLE IF NOT EXISTS `job_delivery` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `job_order_id` bigint(20) NOT NULL COMMENT '설비/치공구 작업지시 원부',
  `order_no_base` char(5) NOT NULL COMMENT '설비/치공구 작업지시번호',
  `order_no_extra` varchar(45) NOT NULL COMMENT '설비/치공구 작업지시번호',
  `order_date` date NOT NULL COMMENT '배송 등록 날짜',
  `carrier_name` varchar(50) NOT NULL COMMENT '발송 업체',
  `carrier_type` varchar(50) NOT NULL COMMENT '발송 종류',
  `destination` varchar(50) NOT NULL COMMENT '도착지',
  `shipping_fee` int(11) NOT NULL COMMENT '배송비',
  `image_file_no1` bigint(20) DEFAULT NULL COMMENT '사진1',
  `image_file_no2` bigint(20) DEFAULT NULL COMMENT '사진2',
  `image_file_no3` bigint(20) DEFAULT NULL COMMENT '사진3',
  `image_file_no4` bigint(20) DEFAULT NULL COMMENT '사진4',
  `image_file_no5` bigint(20) DEFAULT NULL COMMENT '사진5',
  PRIMARY KEY (`id`),
  KEY `FK_job_delivery_registered_file` (`image_file_no1`),
  KEY `order_no_order_no_extra` (`order_no_base`,`order_no_extra`),
  KEY `job_order_id` (`job_order_id`),
  CONSTRAINT `FK_job_delivery_job_order` FOREIGN KEY (`job_order_id`) REFERENCES `job_order` (`id`),
  CONSTRAINT `FK_job_delivery_registered_file` FOREIGN KEY (`image_file_no1`) REFERENCES `registered_file` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='설비/치공구 배송 ';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.job_design_drawing 구조 내보내기
CREATE TABLE IF NOT EXISTS `job_design_drawing` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) NOT NULL,
  `order_type` enum('JOB','JIG') NOT NULL DEFAULT 'JOB' COMMENT '작업 지시 유형. JOB=설비, JIG=치공구',
  `order_no_base` char(5) NOT NULL COMMENT '원 작업지시코드',
  `order_no_extra` varchar(45) NOT NULL COMMENT '원 작업지시코드',
  `drawing_no` char(5) NOT NULL COMMENT '도면번호',
  `reg_date` date DEFAULT NULL,
  `description` varchar(512) NOT NULL COMMENT '설명(엑셀:description)',
  `dimension` varchar(50) NOT NULL COMMENT '가공 사이즈(원재료 사이즈)',
  `material` varchar(50) NOT NULL COMMENT '원재료 종류',
  `thermal` varchar(50) NOT NULL COMMENT '열처리 종류',
  `quantity` int(11) NOT NULL DEFAULT '0' COMMENT '수량',
  `spare` int(11) NOT NULL DEFAULT '0' COMMENT '여분 수량',
  `classification` varchar(50) DEFAULT NULL COMMENT '분류(신규제작,추가제작,...)',
  `reason` varchar(50) NOT NULL DEFAULT '0' COMMENT '사유(설계불량,업체요구,가공불량,...)',
  `postprocessing` varchar(128) NOT NULL DEFAULT '' COMMENT '후처리 종류',
  `note` varchar(512) NOT NULL DEFAULT '0' COMMENT '비고',
  `current_stage` enum('A','B','C','D','E','F','G','S','Z') NOT NULL DEFAULT 'B' COMMENT '설계A, 생관B, 가공C, 검사D, 조립E, 배선F, 후처리G, 생산중지S,납품후작업종료Z',
  `work_status` enum('R','F','C','I','H','S') NOT NULL DEFAULT 'R' COMMENT 'R:대기, F:완료, C:취소, I:작업중, H:홀딩, S:중지',
  `work_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '가공 완료 수량',
  `work_position` enum('I','O','S','D','Z') DEFAULT NULL COMMENT 'I : 사내가공, O : 외주가공, S : 표준품(가공X), D: 표준품 가공, Z:사내가공후외주',
  `outsourcing_partner_id` char(5) DEFAULT NULL COMMENT '외주 업체 코드',
  `outsourcing_estimate_request_id` char(11) DEFAULT NULL COMMENT '견적 요청 ID(job_partner_outsourcing_order 와 join 시 request_type = ''E'' 를 명시해 join 해야함)',
  `outsourcing_request_id` char(11) DEFAULT NULL COMMENT '외주가공 요청ID(job_partner_outsourcing_order 와 join 시 request_type = ''P'' 를 명시해 join 해야함)',
  `process_completed` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '가공완료여부(Y/N)',
  `process_finish_date` date DEFAULT NULL COMMENT '사내/사외 가공 완료일(납기일은 delivery_date 사용)',
  `process_finish_plan_date` date DEFAULT NULL COMMENT '가공 완료 예정일',
  `coating_date` date DEFAULT NULL COMMENT '후처리 완료일',
  `coating_partner_id` char(5) DEFAULT NULL COMMENT '후처리 업체 코드',
  `coating_request_id` char(11) DEFAULT NULL COMMENT '후처리 요청ID',
  `coating_stage` enum('Y','N','S') NOT NULL DEFAULT 'N' COMMENT 'Y:후처리 완료, N:미결, S:스킵',
  `coating_requested` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '후처리 요청 여부(외주가공 발주할 때, 외주가공 업체에서 후처리까지 완료 후 입처리하는 경우)',
  `coating_finish_plan_date` date DEFAULT NULL COMMENT '후처리 완료 예정일',
  `checking` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '검사 여부(Y/N)',
  `inspect_id` bigint(20) DEFAULT NULL COMMENT '검사 정보',
  `inspect_date` date DEFAULT NULL COMMENT '검사 완료일',
  `inspect_plan_date` date DEFAULT NULL COMMENT '검사 완료 예정일',
  `hold_reason` varchar(1024) DEFAULT NULL COMMENT '작업 취소/홀딩/중지 사유',
  `assembly_transfer_from` char(5) DEFAULT NULL COMMENT '가공품 인계자',
  `assembly_transfer_to` char(5) DEFAULT NULL COMMENT '가공품 인수자',
  `assembly_transfer_date` datetime DEFAULT NULL COMMENT '가공품 인수인계 날짜',
  `passStay` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '인계대기중',
  `outToIn` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '사외가공후사내가공여부',
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_type_order_no_base_order_no_extra_drawing_no` (`order_type`,`order_no_base`,`order_no_extra`,`drawing_no`),
  KEY `FK_job_design_drawing_job_order2` (`order_id`),
  KEY `FK_job_design_drawing_buy_partner` (`outsourcing_partner_id`),
  KEY `current_stage` (`current_stage`),
  KEY `work_position` (`work_position`),
  KEY `work_status` (`work_status`),
  KEY `estimate_request_id` (`outsourcing_estimate_request_id`),
  KEY `outsourcing_request_id` (`outsourcing_request_id`),
  KEY `process_completed` (`process_completed`),
  KEY `FK_job_design_drawing_job_inspect` (`inspect_id`),
  CONSTRAINT `FK_job_design_drawing_buy_partner` FOREIGN KEY (`outsourcing_partner_id`) REFERENCES `job_partner` (`id`),
  CONSTRAINT `FK_job_design_drawing_job_order` FOREIGN KEY (`order_type`, `order_no_base`, `order_no_extra`) REFERENCES `job_order` (`order_type`, `order_no_base`, `order_no_extra`),
  CONSTRAINT `FK_job_design_drawing_job_order2` FOREIGN KEY (`order_id`) REFERENCES `job_order` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=771 DEFAULT CHARSET=utf8 COMMENT='설계 도면 원장';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.job_drawing_flow 구조 내보내기
CREATE TABLE IF NOT EXISTS `job_drawing_flow` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) NOT NULL COMMENT '원 작업지시코드',
  `drawing_id` bigint(20) NOT NULL COMMENT '원 작업지시코드',
  `reg_datetime` datetime DEFAULT NULL COMMENT '등록일',
  `reg_user` char(5) NOT NULL COMMENT '등록한 사람',
  `work_type` varchar(50) NOT NULL COMMENT '작업 종류(외주가공 발주, 견적, 검사부 인수인계 등)',
  `passer_user` char(5) DEFAULT NULL COMMENT '인계자',
  `passer_info` varchar(50) DEFAULT NULL COMMENT '인계 정보',
  `receiver_user` char(5) DEFAULT NULL COMMENT '인수자',
  `receive_dept` char(2) DEFAULT NULL COMMENT '인수 부서',
  `receiver_info` varchar(50) DEFAULT NULL COMMENT '인수 정보',
  `note` varchar(512) DEFAULT NULL COMMENT '비고',
  `request_id` char(10) DEFAULT NULL COMMENT '외주가공 요청ID',
  PRIMARY KEY (`id`),
  KEY `FK_job_design_flow_job_order` (`order_id`),
  KEY `FK_job_design_flow_job_design_drawing` (`drawing_id`),
  KEY `IDX_JOB_DRAWING_FLOW` (`order_id`,`drawing_id`),
  CONSTRAINT `FK_job_design_flow_job_design_drawing` FOREIGN KEY (`drawing_id`) REFERENCES `job_order` (`id`),
  CONSTRAINT `FK_job_design_flow_job_order` FOREIGN KEY (`order_id`) REFERENCES `job_order` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='설계 도면 흐름도';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.job_inspect 구조 내보내기
CREATE TABLE IF NOT EXISTS `job_inspect` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `job_drawing_id` bigint(20) NOT NULL COMMENT '도면ID ',
  `get_date` datetime NOT NULL COMMENT '인계 받은 날짜',
  `get_from_id` char(5) NOT NULL COMMENT '검사부로 인계한 사람',
  `get_to_id` char(5) NOT NULL COMMENT '검사부에서 인계받은 사람',
  `work_status` enum('R','F','C','I','H','S') DEFAULT 'R' COMMENT 'R:대기, F:완료, C:취소, I:작업중, H:홀딩, S:중지',
  `start_date` datetime DEFAULT NULL COMMENT '검사 시작 시간',
  `stop_date` datetime DEFAULT NULL COMMENT '검사 중지 시간',
  `requested_date` datetime DEFAULT NULL COMMENT '결과 등록 날짜',
  `deliver_date` datetime DEFAULT NULL COMMENT '인계 등록 날짜(전달날짜)',
  `result_ok` enum('NG','PASS') DEFAULT 'NG' COMMENT '검사판정 OK여부 (NG/PASS)',
  `result_file_id` bigint(20) DEFAULT NULL COMMENT '검사 성적서 파일 정보 ',
  `put_from_id` char(5) DEFAULT NULL COMMENT '검사후 생관으로 인계한 사람(검사부)',
  `put_to_id` char(5) DEFAULT NULL COMMENT '검사후 인계받은 사람(생관)',
  `ok_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '합격 수량',
  `fail_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '불합격 수량',
  `inspect_progress` smallint(6) NOT NULL DEFAULT '0' COMMENT '검사 진행률(미정)',
  `is_delivery` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '인수인계 여부',
  `hold_reason` varchar(1024) DEFAULT NULL COMMENT '작업 취소/홀딩/중지 사유',
  PRIMARY KEY (`id`),
  KEY `job_drawing_id` (`job_drawing_id`),
  CONSTRAINT `FK_job_inspect_job_design_drawing` FOREIGN KEY (`job_drawing_id`) REFERENCES `job_design_drawing` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='검사결과 원장 테이블';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.job_mct 구조 내보내기
CREATE TABLE IF NOT EXISTS `job_mct` (
  `id` int(11) NOT NULL COMMENT '기계번호',
  `machine_name` varchar(50) NOT NULL COMMENT '기계이름',
  `work_status` enum('R','F','I','H','S','C') NOT NULL DEFAULT 'R' COMMENT 'R:대기, F:완료, I:작업중, H:홀딩, S:중지, C:취소',
  `design_drawing_id` bigint(20) DEFAULT NULL COMMENT '설계도ID',
  `user_id` char(5) DEFAULT '' COMMENT '가공 작업자',
  `work_text` varchar(256) DEFAULT '대기' COMMENT '현재 작업상태를 Text로 표현',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='기계 현황';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.job_mct_history 구조 내보내기
CREATE TABLE IF NOT EXISTS `job_mct_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mct_id` int(11) NOT NULL COMMENT '기계번호',
  `user_id` char(5) NOT NULL COMMENT '가공 작업자',
  `drawing_id` bigint(20) NOT NULL,
  `start_datetime` datetime NOT NULL COMMENT '작업 시작 시간',
  `end_datetime` datetime DEFAULT NULL COMMENT '작업 종료 시간',
  `workMin` bigint(20) DEFAULT NULL COMMENT '작업 소요 시간',
  `order_type` enum('JOB','JIG') NOT NULL DEFAULT 'JOB' COMMENT '작업 지시 유형. JOB=설비, JIG=치공구',
  `order_no_base` char(5) NOT NULL COMMENT '원 작업지시코드',
  `order_no_extra` varchar(45) NOT NULL COMMENT '원 작업지시코드',
  `drawing_no` char(4) NOT NULL COMMENT '도면번호',
  `work_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '가공 완료 수량',
  `finish_status` char(1) NOT NULL DEFAULT 'R' COMMENT '작업완료 상황, R:대기, S:일시중지, F:최종완료, C:취소, I:작업중, E:1/2차 완료',
  `hold_reason` varchar(1024) DEFAULT NULL COMMENT '작업 취소/홀딩/중지 사유',
  PRIMARY KEY (`id`),
  KEY `PR_job_MCT_history` (`mct_id`,`user_id`,`drawing_id`,`start_datetime`)
) ENGINE=InnoDB AUTO_INCREMENT=336 DEFAULT CHARSET=utf8 COMMENT='가공 History';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.job_mct_his_log 구조 내보내기
CREATE TABLE IF NOT EXISTS `job_mct_his_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mct_id` int(11) NOT NULL COMMENT '기계번호',
  `user_id` char(5) NOT NULL COMMENT '가공 작업자',
  `start_datetime` datetime NOT NULL COMMENT '작업 시작 시간',
  `end_datetime` datetime DEFAULT NULL COMMENT '작업 종료 시간',
  `order_type` enum('JOB','JIG') NOT NULL DEFAULT 'JOB' COMMENT '작업 지시 유형. JOB=설비, JIG=치공구',
  `order_no_base` char(5) NOT NULL COMMENT '원 작업지시코드',
  `order_no_extra` varchar(45) NOT NULL COMMENT '원 작업지시코드',
  `drawing_no` char(4) NOT NULL COMMENT '도면번호',
  `work_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '가공 완료 수량',
  `finish_status` char(1) NOT NULL DEFAULT 'R' COMMENT '작업완료 상황, R:대기, F:완료, C:취소, I:작업중, H:홀딩, S:일시중지',
  `hold_reason` varchar(1024) DEFAULT NULL COMMENT '작업 취소/홀딩/중지 사유',
  `drawing_id` bigint(20) NOT NULL,
  `description` varchar(512) NOT NULL COMMENT '설명(엑셀:description)',
  `dimension` varchar(50) NOT NULL COMMENT '가공 사이즈(원재료 사이즈)',
  `material` varchar(50) NOT NULL COMMENT '원재료 종류',
  `thermal` varchar(50) NOT NULL COMMENT '열처리 종류',
  `postprocessing` varchar(50) NOT NULL DEFAULT '' COMMENT '후처리 종류',
  `quantity` int(11) NOT NULL DEFAULT '0' COMMENT '수량',
  `spare` int(11) NOT NULL DEFAULT '0' COMMENT '여분 수량',
  `order_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `PR_job_MCT_history` (`mct_id`,`user_id`,`drawing_id`,`start_datetime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='가공 History LOG';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.job_order 구조 내보내기
CREATE TABLE IF NOT EXISTS `job_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_type` enum('JOB','JIG') NOT NULL DEFAULT 'JOB' COMMENT '작업 지시 유형. JOB=설비, JIG=치공구',
  `order_date` date DEFAULT NULL COMMENT '발주일/기록일',
  `customer_id` char(2) NOT NULL COMMENT '업체',
  `order_no_base` char(5) NOT NULL COMMENT '자동 생성된 Order No',
  `order_no_extra` varchar(45) NOT NULL DEFAULT '' COMMENT '자동 생성된 Order No',
  `reMake` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '재제작 여부(Y/N)',
  `deleted` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '삭제 여부(Y/N)',
  `current_stage` enum('A','B','C','D','H','F') NOT NULL COMMENT 'A:진행중,B:Setup중,H:홀딩(중단)중,F:완료,D:배송,C:중단(cut)',
  `device` varchar(128) NOT NULL COMMENT 'Device',
  `business_user_id` char(5) NOT NULL COMMENT '영업 담당',
  `design_user_id` char(5) NOT NULL COMMENT '설계 담당',
  `customer_user` varchar(30) NOT NULL COMMENT '고객사 담당자',
  `assembly_id` char(5) DEFAULT NULL COMMENT '조립 담당자',
  `pgm_id` char(5) DEFAULT NULL COMMENT 'PGM 담당자',
  `wiring_id` char(5) DEFAULT NULL COMMENT '배선 담당자',
  `note` text COMMENT '비고',
  `estimated_days` int(11) DEFAULT NULL COMMENT '소요 기간(일)',
  `quantity` int(11) DEFAULT NULL COMMENT '수량(치공구를 제외한 유형에서만 사용)',
  `internal_unit_price` bigint(20) DEFAULT NULL COMMENT '내부 단가',
  `estimated_price` bigint(20) DEFAULT NULL COMMENT '견적 금액',
  `negotiated_price` bigint(20) DEFAULT NULL COMMENT '네고 가격',
  `internal_price_file_no` bigint(20) DEFAULT NULL COMMENT '내부 단가 파일 번호',
  `concept_file_no` bigint(20) DEFAULT NULL COMMENT '컨셉 도면 파일 번호',
  `internal_unit_price_shared_date` date DEFAULT NULL COMMENT '내부단가 공유일',
  `shipping_date` date DEFAULT NULL COMMENT '출고일 (설비 작업 지시 때)',
  `delivery_date` date DEFAULT NULL COMMENT '배송일',
  `test_date` date DEFAULT NULL COMMENT '검사일',
  `install_date` date DEFAULT NULL COMMENT '납품일(D-DAY)',
  `real_install_date` date DEFAULT NULL COMMENT '실납품일(영업부 전용)',
  `design_progress` smallint(6) NOT NULL DEFAULT '0' COMMENT '설계 진행률(수동입력)',
  `design_status` enum('R','F','C','I','H','S') NOT NULL DEFAULT 'R' COMMENT 'R:대기, F:완료, C:취소, I:작업중, H:홀딩, S:중지',
  `design_date` date DEFAULT NULL COMMENT '도면 출도 예정일',
  `design_start` datetime DEFAULT NULL COMMENT '도면 작업 시작일',
  `design_end` datetime DEFAULT NULL COMMENT '도면출도 완료일',
  `assembly_progress` smallint(6) NOT NULL DEFAULT '0' COMMENT '조립 진행률(수동입력)',
  `assembly_status` enum('R','F','C','I','H','S') NOT NULL DEFAULT 'R' COMMENT 'R:대기, F:완료, C:취소, I:작업중, H:홀딩, S:중지',
  `assembly_date` date DEFAULT NULL COMMENT '조립일 예정일',
  `assembly_start` datetime DEFAULT NULL COMMENT '조립시작일',
  `assembly_end` datetime DEFAULT NULL COMMENT '조립완료일',
  `program_progress` smallint(6) NOT NULL DEFAULT '0' COMMENT '프로그램 진행률(수동입력)',
  `program_status` enum('R','F','C','I','H','S') NOT NULL DEFAULT 'R' COMMENT 'R:대기, F:완료, C:취소, I:작업중, H:홀딩, S:중지',
  `program_date` date DEFAULT NULL COMMENT 'PGM 완료예정일',
  `program_start` datetime DEFAULT NULL COMMENT 'PGM 시작일',
  `program_end` datetime DEFAULT NULL COMMENT 'PGM 완료일',
  `wiring_status` enum('R','F','C','I','H','S') NOT NULL DEFAULT 'R' COMMENT 'R:대기, F:완료, C:취소, I:작업중, H:홀딩, S:중지',
  `wiring_date` date DEFAULT NULL COMMENT '배선 완료예정일',
  `wiring_start` datetime DEFAULT NULL COMMENT '배선 시작일',
  `wiring_end` datetime DEFAULT NULL COMMENT '배선 완료일',
  `process_progress` smallint(6) NOT NULL DEFAULT '0' COMMENT '가공 진행률(미정)',
  `process_date` date DEFAULT NULL COMMENT '가공완료 예정일',
  `purchase_progress` smallint(6) NOT NULL DEFAULT '0' COMMENT '구매 진행률(미정)',
  `purchase_date` date DEFAULT NULL COMMENT '구매일 완료예정일',
  `purchase_none` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '구매품 없음',
  `setup_id` bigint(20) DEFAULT NULL COMMENT 'job_setup 테이블 ID',
  `last_modified_user_id` char(5) DEFAULT NULL COMMENT '마지막 수정한 사람',
  `last_modified_when` datetime DEFAULT NULL COMMENT '마지막 수정 시각',
  `moveYN` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '가공품 이관 가능 Order 여부',
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_no` (`order_type`,`order_no_base`,`order_no_extra`),
  KEY `FK_equipment_job_order_user` (`business_user_id`),
  KEY `FK_equipment_job_order_user_2` (`design_user_id`),
  KEY `FK_equipment_job_order_user_3` (`customer_user`),
  KEY `deleted` (`deleted`),
  KEY `FK_equipment_job_order_partner` (`customer_id`),
  KEY `FK_equipment_job_order_registered_file` (`internal_price_file_no`),
  KEY `FK_equipment_job_order_registered_file_2` (`concept_file_no`),
  KEY `order_type` (`order_type`),
  KEY `current_stage` (`current_stage`),
  KEY `install_date_idx` (`install_date`),
  CONSTRAINT `FK_equipment_job_order_partner` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  CONSTRAINT `FK_equipment_job_order_registered_file` FOREIGN KEY (`internal_price_file_no`) REFERENCES `registered_file` (`id`),
  CONSTRAINT `FK_equipment_job_order_registered_file_2` FOREIGN KEY (`concept_file_no`) REFERENCES `registered_file` (`id`),
  CONSTRAINT `FK_equipment_job_order_user` FOREIGN KEY (`business_user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_equipment_job_order_user_2` FOREIGN KEY (`design_user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8 COMMENT='설비/치공구 작업 원장';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.job_order_field_data 구조 내보내기
CREATE TABLE IF NOT EXISTS `job_order_field_data` (
  `class` varchar(50) NOT NULL,
  `field_name` varchar(50) NOT NULL,
  `class_name` varchar(50) NOT NULL,
  `display_name` varchar(50) NOT NULL,
  PRIMARY KEY (`class`,`field_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='변경 내역에 필드 설명 추가';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.job_order_modification_history 구조 내보내기
CREATE TABLE IF NOT EXISTS `job_order_modification_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `job_order_id` bigint(20) NOT NULL COMMENT '변경 작업한 작업 ID',
  `source_category` enum('ORDER','DESIGN','CONCEPT') NOT NULL COMMENT '변경 범주(CONCEPT = 컨셉작업지시, ORDER = 작업지시, DESIGN = 설계), job_order_id 가 어디건지',
  `change_type` enum('CHANGE','DELETE') NOT NULL COMMENT 'CHANGE = 값 변경, DELETE = 작업삭제',
  `user_id` char(5) NOT NULL COMMENT '수정한 사람',
  `when_modified` datetime NOT NULL COMMENT '수정 시각',
  PRIMARY KEY (`id`),
  KEY `concept_job_id` (`job_order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=345 DEFAULT CHARSET=utf8 COMMENT='컨셉 설비 등의 변경 내역';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.job_order_modified_value 구조 내보내기
CREATE TABLE IF NOT EXISTS `job_order_modified_value` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `job_order_change_id` bigint(20) NOT NULL,
  `field_name` varchar(128) NOT NULL,
  `before` varchar(512) DEFAULT NULL,
  `after` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_job_order_change_value_history_job_order_change_history` (`job_order_change_id`),
  CONSTRAINT `FK_job_order_change_value_history_job_order_change_history` FOREIGN KEY (`job_order_change_id`) REFERENCES `job_order_modification_history` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8 COMMENT='저장할때마다 변경 전, 변경 후 값';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.job_partner 구조 내보내기
CREATE TABLE IF NOT EXISTS `job_partner` (
  `id` char(5) NOT NULL COMMENT '업체코드=업체대분류(type_code) + 업체소분류(type_kind) + 3자리 순번',
  `type_code` enum('O','C','X','L','T','V','R','G','F','W','D','S','X','E','M','A') NOT NULL COMMENT '대분류-M(가공),W(복리후생),P(후처리),S(원자재)',
  `type_kind` enum('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','W','Z','0') NOT NULL COMMENT '소분류-S(판금),C(MCT가공),T(선반),ㅇ(식당)',
  `partner_name` varchar(64) NOT NULL COMMENT '업체명',
  `billing_name` varchar(50) DEFAULT NULL COMMENT '계산서 업체명',
  `billing_after` varchar(5) DEFAULT NULL COMMENT '결제 기준',
  `billing_day` varchar(5) DEFAULT NULL COMMENT '결제일',
  `bank_name` varchar(50) DEFAULT NULL COMMENT '결제 계좌 은행',
  `bank_account` varchar(50) DEFAULT NULL COMMENT '결제 계좌 번호',
  `corporate_num` char(12) NOT NULL COMMENT '사업자번호',
  `corporate_phone` varchar(15) NOT NULL COMMENT '회사 전화번호',
  `corporate_mail` varchar(100) DEFAULT NULL COMMENT '회사 대표메일',
  `corporate_addr` varchar(100) NOT NULL COMMENT '회사 주소',
  `person_name` varchar(20) DEFAULT NULL COMMENT '담당자 이름',
  `person_position` varchar(20) DEFAULT NULL COMMENT '담당자 직급',
  `person_mail` varchar(50) DEFAULT NULL COMMENT '담당자 이메일',
  `person_phone` varchar(15) DEFAULT NULL COMMENT '담당자 연락처',
  `view_processmanagement` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '생관관련 업체 여부(Y/N)',
  `view_purchase` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '구매관련 업체 여부(Y/N)',
  `view_process` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '가공관련 업체 여부(Y/N)',
  `view_assemble` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '조립관련 업체 여부(Y/N)',
  `view_financial` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '재무관리부 관련 업체 여부(Y/N)',
  `processEnjoy` enum('Y','N') NOT NULL DEFAULT 'Y' COMMENT '생관 관련 업체 즐겨찾기 여부(Y/N)',
  `note` text COMMENT '비고',
  PRIMARY KEY (`id`),
  KEY `FK_buy_billing_billing_after_data` (`billing_after`),
  KEY `FK_buy_billing_billing_day_data` (`billing_day`),
  KEY `FK_buy_partner_type` (`type_code`,`type_kind`),
  KEY `partner_name` (`partner_name`),
  CONSTRAINT `FK_buy_billing_billing_after_data` FOREIGN KEY (`billing_after`) REFERENCES `billing_after_data` (`id`),
  CONSTRAINT `FK_buy_billing_billing_day_data` FOREIGN KEY (`billing_day`) REFERENCES `billing_day_data` (`id`),
  CONSTRAINT `FK_job_partner_job_partner_type` FOREIGN KEY (`type_code`, `type_kind`) REFERENCES `job_partner_type` (`type_code`, `type_kind`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='매입 거래처 ';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.job_partner_outsourcing_order 구조 내보내기
CREATE TABLE IF NOT EXISTS `job_partner_outsourcing_order` (
  `id` char(11) NOT NULL COMMENT '요청ID (yyMMdd-nnnn)',
  `job_design_drawing_id` bigint(20) NOT NULL COMMENT '도면ID ',
  `job_order_id` bigint(20) NOT NULL COMMENT '작업지시ID',
  `request_type` enum('E','P','C','D') NOT NULL COMMENT 'E:견적, P:가공발주, C:후처리, D:후처리취소',
  `partner_id` char(5) NOT NULL COMMENT '업체ID',
  `request_date` datetime NOT NULL COMMENT '등록 날짜',
  `delivery_date` date DEFAULT NULL COMMENT '납기일(가공완료일, 입고처리일)',
  `delivery_plan_date` date NOT NULL COMMENT '납기예정일(가공완료예정일)',
  `drawing_url` varchar(256) DEFAULT NULL COMMENT '도면 URL',
  `unit_price` int(11) DEFAULT NULL COMMENT '발주 단가(발주 때 사용)',
  `quantity` int(11) DEFAULT NULL COMMENT '수량',
  `spare` int(11) DEFAULT NULL COMMENT 'spare ',
  `with_postprocessing` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '후처리 여부',
  `is_receive` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '외주가공 입고 여부',
  `uid` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '내부 처리용 식별자 (팝업 등 단순 ID 용도)',
  `statement_of_account_detail_id` bigint(20) DEFAULT NULL COMMENT '거래명세서 상세 ID',
  `abort_reason` varchar(256) DEFAULT NULL COMMENT '발주 취소 사유',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `id_job_design_drawing_id_request_type_partner_id` (`id`,`job_design_drawing_id`,`request_type`,`partner_id`),
  KEY `FK_job_partner_outsourcing_order_job_design_drawing` (`job_design_drawing_id`),
  KEY `FK_job_partner_outsourcing_order_job_order` (`job_order_id`),
  KEY `FK_job_partner_outsourcing_order_statement_of_account_detail` (`statement_of_account_detail_id`),
  CONSTRAINT `FK_job_partner_outsourcing_order_job_design_drawing` FOREIGN KEY (`job_design_drawing_id`) REFERENCES `job_design_drawing` (`id`),
  CONSTRAINT `FK_job_partner_outsourcing_order_job_order` FOREIGN KEY (`job_order_id`) REFERENCES `job_order` (`id`),
  CONSTRAINT `FK_job_partner_outsourcing_order_statement_of_account_detail` FOREIGN KEY (`statement_of_account_detail_id`) REFERENCES `statement_of_account_detail` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=utf8 COMMENT='외주 가공 견적서/발주 요청 내역\r\n\r\n 화면표기=cccccXyyMMdd-nnnn\r\n              partner_id(5) + request_type(1) + id(10)';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.job_partner_type 구조 내보내기
CREATE TABLE IF NOT EXISTS `job_partner_type` (
  `type_code` enum('O','C','X','L','T','V','R','G','F','W','D','S','X','E','M','A') NOT NULL COMMENT '외주가공코드',
  `type_kind` enum('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','W','Z','0') NOT NULL COMMENT '소분류코드',
  `type_name` varchar(64) NOT NULL COMMENT '업체종류 이름(가공-판금, 가공-선반, 가공-MCT, 구내식당',
  `next_value` int(11) NOT NULL DEFAULT '0' COMMENT '업체종류에 생성된 업체코드 순번',
  PRIMARY KEY (`type_code`,`type_kind`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='매입거래처 종류';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.job_processing 구조 내보내기
CREATE TABLE IF NOT EXISTS `job_processing` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `drawing_id` bigint(20) NOT NULL,
  `user_id` char(5) NOT NULL COMMENT '가공 작업자',
  `mct_id` int(11) NOT NULL COMMENT '작업 기계 번호',
  `start_datetime` datetime NOT NULL COMMENT '작업 시작 시간',
  `end_datetime` datetime DEFAULT NULL COMMENT '작업 종료 시간',
  `work_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '가공 수량',
  PRIMARY KEY (`id`),
  KEY `FK_job_processing_design_drawing` (`drawing_id`),
  KEY `PK_job_processing` (`drawing_id`,`user_id`,`mct_id`,`start_datetime`),
  CONSTRAINT `FK_job_processing_design_drawing` FOREIGN KEY (`drawing_id`) REFERENCES `job_design_drawing` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=326 DEFAULT CHARSET=utf8 COMMENT='가공 원장';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.job_purchase 구조 내보내기
CREATE TABLE IF NOT EXISTS `job_purchase` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '내부 ID',
  `job_design_drawing_Id` bigint(20) DEFAULT NULL COMMENT '구매 대상의 도면 식별자',
  `job_order_id` bigint(20) NOT NULL COMMENT '구매 대상의 작업 지시 번호',
  `customer_id` char(2) NOT NULL COMMENT '해당 작업 지시건의 고객ID',
  `reg_date` date NOT NULL COMMENT '구매 리스트 등록 날짜',
  `unit_no` varchar(4) DEFAULT NULL,
  `seq` varchar(3) DEFAULT NULL,
  `description` varchar(128) DEFAULT NULL,
  `model_no` varchar(128) NOT NULL,
  `maker` varchar(128) NOT NULL,
  `partner_id` char(5) NOT NULL COMMENT '업체 ID',
  `quantity` int(11) DEFAULT NULL,
  `spare` int(11) DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL,
  `comment` varchar(50) DEFAULT NULL,
  `remark` varchar(50) DEFAULT NULL,
  `design_file_no` bigint(20) DEFAULT NULL,
  `stage` enum('R','E','P','F','O','Z') NOT NULL DEFAULT 'R' COMMENT '''R'' - 구매등록 상태, ''E'' - 견적요청중, ''P'' - 구매요청, ''F'' - 입고완료, ''O'' - 불출완료, ''Z'' - 전체반품구매재등록',
  `order_request_id` char(20) DEFAULT NULL,
  `order_requested_when` datetime DEFAULT NULL,
  `order_request_user_id` char(5) DEFAULT NULL,
  `deleted` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '삭제 여부',
  `delete_reason` varchar(256) DEFAULT NULL COMMENT '삭제 사유',
  `delete_user_id` char(5) DEFAULT NULL,
  `warehousing_quantity` int(11) DEFAULT NULL COMMENT '입고수량',
  `warehousing_user` varchar(5) DEFAULT NULL COMMENT '입고자',
  `warehousing_date` date DEFAULT NULL COMMENT '입고날짜',
  `pass_date` date DEFAULT NULL COMMENT '불출날짜',
  `pass_usr` varchar(5) DEFAULT NULL COMMENT '인계자',
  `receiver_usr` varchar(5) DEFAULT NULL COMMENT '인수자',
  `receive_dept` char(2) DEFAULT NULL COMMENT '입고부서',
  `out_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '반품수량',
  `out_user` varchar(5) DEFAULT NULL COMMENT '반품자',
  `out_reason` text COMMENT '반품사유',
  `statement_type` enum('A','X','S') NOT NULL DEFAULT 'X' COMMENT '''A'' - 전체등록 완료, ''X'' - 전체등록 미완료, ''S'' - 부분등록',
  `stock_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '재고등록 수량',
  `stock_use_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '재고사용 수량',
  `robin_request_date` date DEFAULT NULL COMMENT '구매 품의서 납기요청 날짜',
  `round_robinYN` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '품의서 구매품 여부',
  PRIMARY KEY (`id`),
  KEY `FK_job_purchase_job_design_drawing` (`job_design_drawing_Id`),
  KEY `stage` (`stage`),
  KEY `FK_job_purchase_job_partner` (`partner_id`),
  KEY `FK_job_purchase_customer` (`customer_id`),
  KEY `FK_job_purchase_job_order` (`job_order_id`),
  KEY `deleted` (`deleted`),
  CONSTRAINT `FK_job_purchase_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  CONSTRAINT `FK_job_purchase_job_design_drawing` FOREIGN KEY (`job_design_drawing_Id`) REFERENCES `job_design_drawing` (`id`),
  CONSTRAINT `FK_job_purchase_job_order` FOREIGN KEY (`job_order_id`) REFERENCES `job_order` (`id`),
  CONSTRAINT `FK_job_purchase_job_partner` FOREIGN KEY (`partner_id`) REFERENCES `job_partner` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=368 DEFAULT CHARSET=utf8 COMMENT='구매 원장';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.job_setup 구조 내보내기
CREATE TABLE IF NOT EXISTS `job_setup` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) NOT NULL COMMENT 'job_order 테이블 id',
  `work_status` enum('R','F','C','I','O','H','S') NOT NULL DEFAULT 'R' COMMENT 'R:대기, F:완료, C:취소, I:사내작업중, O:고객사작업중, H:홀딩, S:중지',
  `expect_buyoff_in_date` date NOT NULL COMMENT '예상 내부 Buyoff 날짜',
  `expect_buyoff_out_date` date NOT NULL COMMENT '예상 고객사 Buyoff 날짜',
  `expect_shipping_date` date NOT NULL COMMENT '예상 출고날짜',
  `expect_finish_date` date NOT NULL COMMENT '예상 셋업 완료날짜',
  `finish_buyoff_in_date` date DEFAULT NULL COMMENT '내부 Buyoff 종료날짜',
  `finish_buyoff_out_date` date DEFAULT NULL COMMENT '고객사 Buyoff 종료날짜',
  `shipping_date` date DEFAULT NULL COMMENT '실제 출고일',
  `setup_start_date` date DEFAULT NULL COMMENT 'setup 시작 날짜',
  `setup_finish_date` date DEFAULT NULL COMMENT 'setup 완료 날짜',
  `out_setup_start_date` date DEFAULT NULL COMMENT '출장 시작날짜',
  `out_setup_finish_date` date DEFAULT NULL COMMENT '출장 종료날짜',
  `note` text COMMENT '특이사항',
  `manager_id` char(5) NOT NULL COMMENT '셋업 팀장',
  `assemble1_id` char(5) DEFAULT NULL COMMENT '조립 담당1',
  `assemble2_id` char(5) DEFAULT NULL COMMENT '조립 담당2',
  `assemble3_id` char(5) DEFAULT NULL COMMENT '조립 담당3',
  `pgm1_id` char(5) DEFAULT NULL COMMENT '프로그램 담당1',
  `pgm2_id` char(5) DEFAULT NULL COMMENT '프로그램 담당2',
  `pgm3_id` char(5) DEFAULT NULL COMMENT '프로그램 담당3',
  `wiring1_id` char(5) DEFAULT NULL COMMENT '배선 담당1',
  `wiring2_id` char(5) DEFAULT NULL COMMENT '배선 담당2',
  `wiring3_id` char(5) DEFAULT NULL COMMENT '배선 담당3',
  `robot1_id` char(5) DEFAULT NULL COMMENT '로봇 담당1',
  `robot2_id` char(5) DEFAULT NULL COMMENT '로봇 담당2',
  `robot3_id` char(5) DEFAULT NULL COMMENT '로봇 담당3',
  `business1_id` char(5) DEFAULT NULL COMMENT '영업 담당1',
  `business2_id` char(5) DEFAULT NULL COMMENT '영업 담당2',
  `business3_id` char(5) DEFAULT NULL COMMENT '영업 담당3',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='셋업 원장';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.job_wage_rate 구조 내보내기
CREATE TABLE IF NOT EXISTS `job_wage_rate` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `job_order_id` bigint(20) NOT NULL COMMENT '변경 작업한 작업 ID',
  `design_user_id` char(5) DEFAULT NULL COMMENT '설계 담당',
  `assembly_user_id` char(5) DEFAULT NULL COMMENT '조립 담당',
  `program_user_id` char(5) DEFAULT NULL COMMENT '프로그램 담당',
  `work_day` int(11) NOT NULL COMMENT '작업 기간',
  `work_kind` enum('D','A','P') NOT NULL COMMENT 'D:설계임율, A:조립임율, P:프로그램임율',
  PRIMARY KEY (`id`),
  KEY `FK_job_wage_rate_job_order` (`job_order_id`),
  CONSTRAINT `FK_job_wage_rate_job_order` FOREIGN KEY (`job_order_id`) REFERENCES `job_order` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='작업 임률 테이블';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.leave_application 구조 내보내기
CREATE TABLE IF NOT EXISTS `leave_application` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '내부 ID',
  `preId` bigint(20) DEFAULT NULL COMMENT '변경전ID',
  `title` varchar(128) NOT NULL DEFAULT '연차' COMMENT '휴가종류',
  `request_reason` varchar(256) DEFAULT NULL COMMENT '휴가 요청 사유',
  `reg_date` date NOT NULL COMMENT '휴가원 등록 날짜',
  `request_dept` char(2) NOT NULL COMMENT '요청자부서',
  `request_usr` varchar(5) NOT NULL COMMENT '요청자',
  `request_strdate` date NOT NULL COMMENT '연차 시작 날짜',
  `request_enddate` date NOT NULL COMMENT '연차 종료 날짜',
  `request_date` int(11) DEFAULT NULL COMMENT '연차 사용 일수',
  `request_hour` int(11) DEFAULT NULL COMMENT '외출/조퇴 사용 시간',
  `kind` enum('A','B','C') NOT NULL DEFAULT 'A' COMMENT '''A'' - 연차삭감, ''B'' - 연차삭감하지않음, ''C'' - 조퇴/외출',
  `kind_dept` enum('A','B') NOT NULL DEFAULT 'A' COMMENT '''A'' - 2층부서, ''B'' - 1층부서',
  `conform_stage` enum('R','M','J','C') NOT NULL DEFAULT 'R' COMMENT '''R'' - 본인결제완료, ''M'' - 팀장결제완료, ''J'' - 이사결제완료, ''C'' - 대표이사결제완료',
  `sign_r` varchar(256) NOT NULL COMMENT '본인 싸인 이미지 path',
  `sign_m` varchar(256) DEFAULT NULL COMMENT '팀장 싸인 이미지 path',
  `m_date` date DEFAULT NULL COMMENT '팀장결제 날짜',
  `sign_j` varchar(256) DEFAULT NULL COMMENT '이사 싸인 이미지 path',
  `j_date` date DEFAULT NULL COMMENT '이사결제 날짜',
  `sign_c` varchar(256) DEFAULT NULL COMMENT '대표이사 싸인 이미지 path',
  `c_date` date DEFAULT NULL COMMENT '대표이사이사결제 날짜',
  `complet` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '완료 여부',
  `deleted` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '삭제 여부',
  `changed` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '변경된 휴가원 여부',
  `delete_reason` varchar(256) DEFAULT NULL COMMENT '삭제 사유',
  `delete_user_id` char(5) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COMMENT='휴가원';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.machine_stock 구조 내보내기
CREATE TABLE IF NOT EXISTS `machine_stock` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `drawing_id` bigint(20) NOT NULL COMMENT 'job_design_drawing 테이블 PK',
  `order_type` enum('JOB','JIG') NOT NULL DEFAULT 'JOB' COMMENT '작업 지시 유형. JOB=설비, JIG=치공구',
  `order_no_base` char(5) NOT NULL COMMENT '원 작업지시코드',
  `order_no_extra` varchar(45) NOT NULL COMMENT '원 작업지시코드',
  `drawing_no` char(4) NOT NULL COMMENT '도면번호',
  `store_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '가공품 재고 수량',
  `save_datetime` datetime NOT NULL COMMENT '재고 저장 시간',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='가공품 재고현황';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.mailing 구조 내보내기
CREATE TABLE IF NOT EXISTS `mailing` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `subject` varchar(256) NOT NULL COMMENT '이메일 제목',
  `body` mediumtext NOT NULL COMMENT '본문',
  `from_user_id` char(5) NOT NULL COMMENT '발송자',
  `registered_date` datetime DEFAULT NULL COMMENT '메일 발송 요청 시각',
  `send_status` enum('R','F','E','Q') NOT NULL DEFAULT 'R' COMMENT '메일 발송 상태(R:대기,''Q'':발송중, F:완료, E:오류)',
  `sent_date` datetime DEFAULT NULL COMMENT '발송 시각(NOT NULL = 발송 완료)',
  `hint` varchar(50) DEFAULT NULL COMMENT '??',
  `request_id` varchar(50) DEFAULT NULL,
  `request_group` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sending_idx` (`send_status`)
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8 COMMENT='메일 발송 원장';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.mailing_recipients 구조 내보내기
CREATE TABLE IF NOT EXISTS `mailing_recipients` (
  `mailing_id` bigint(20) NOT NULL,
  `recipient` char(5) DEFAULT NULL,
  `external_recipient` varchar(128) DEFAULT NULL,
  `recipient_type` enum('CC','TO') DEFAULT 'TO' COMMENT '받을 사람의 유형 ''TO : 수신인, ''CC'' : 참조',
  KEY `mailing_id` (`mailing_id`),
  KEY `FK_mailing_recipients_user` (`recipient`),
  CONSTRAINT `FK_mailing_recipients_user` FOREIGN KEY (`recipient`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='메일 발송시 수신자 정보';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.menu_data 구조 내보내기
CREATE TABLE IF NOT EXISTS `menu_data` (
  `high_code` char(2) NOT NULL COMMENT '대 메뉴 코드',
  `low_code` char(2) NOT NULL COMMENT '하위 메뉴 코드(''00'' : 상위 메뉴)',
  `list_code` char(2) NOT NULL COMMENT '하위 메뉴 리스트 코드(''00'' : 상위 메뉴)',
  `title` varchar(50) NOT NULL COMMENT '메뉴 표기명',
  `url` varchar(50) NOT NULL COMMENT '해당 메뉴 URL',
  `visible` enum('Y','N') NOT NULL DEFAULT 'Y' COMMENT '표시 여부',
  `admin_only` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '관리자 전용 메뉴 여부',
  `upAndview` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT 'view 권한 시 update 권한',
  PRIMARY KEY (`high_code`,`low_code`,`list_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='메뉴 목록 테이블';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.message 구조 내보내기
CREATE TABLE IF NOT EXISTS `message` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sender_user_id` char(5) NOT NULL COMMENT '보낸 사람',
  `receiver_user_id` char(5) NOT NULL COMMENT '받는 사람',
  `title` varchar(50) NOT NULL COMMENT '제목',
  `body` text NOT NULL COMMENT '본문',
  `when_received` datetime NOT NULL COMMENT '수신 시각',
  `when_read` datetime DEFAULT NULL COMMENT '읽은 시각(NULL=아직 안 읽은 메세지)',
  `when_deleted` datetime DEFAULT NULL COMMENT '삭제 시각(NULL=미삭제)',
  PRIMARY KEY (`id`),
  KEY `FK_message_user` (`sender_user_id`),
  KEY `FK_message_user_2` (`receiver_user_id`),
  CONSTRAINT `FK_message_user` FOREIGN KEY (`sender_user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_message_user_2` FOREIGN KEY (`receiver_user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='쪽지';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.notice_message 구조 내보내기
CREATE TABLE IF NOT EXISTS `notice_message` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `alarm_type` enum('G','E','A','B','C') NOT NULL COMMENT '알람종류(G:일반,E:경고,A:입고품,B:품의서,C:결제)',
  `alarm_kind` enum('A','PQ','AD','FM','MC','MM','T1','T2','TS','M','D','F','C') NOT NULL DEFAULT 'A' COMMENT '알람부서종류(A:전체알람, PQ:구매, AD:조립, FM:관리, MC:가공, MM:생관, T1:설계, T2:연구소, TS:영업, M:팀장, D:재무이사, F:공장장, C:대표이사 )',
  `alarm_manager` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '팀장 알람 여부',
  `dept_code` char(2) DEFAULT NULL COMMENT '알람과 관련된 부서(null:전체부서, AA:임원진,FM:재무관리부,TS:기술영업부,MC:가공부,..)',
  `job_order_id` bigint(20) DEFAULT NULL COMMENT '연관된 설비/치공구 작업지시 ID',
  `message_type` varchar(50) DEFAULT NULL COMMENT '메세지 종류(조립가능, 납기지연, 도면출도)',
  `message` text NOT NULL COMMENT '알람 내용',
  `when_received` datetime DEFAULT NULL COMMENT '수신 시각',
  `when_created` datetime NOT NULL COMMENT '메세지 등록 시각',
  `device` varchar(255) DEFAULT NULL COMMENT 'Device 설명',
  `customer` varchar(50) DEFAULT NULL COMMENT '고객사명',
  `sumprice` int(11) DEFAULT NULL COMMENT '품의서 합계액',
  `kind` varchar(20) DEFAULT NULL COMMENT '연차/연장근무 종류(조퇴,반차,연장,휴일)',
  `useDate` varchar(100) DEFAULT NULL COMMENT '연차 사용일(시간), 연장근무 사용시간',
  `requestDate` varchar(100) DEFAULT NULL COMMENT '사용기간(연차)/사용시간(근무) 0:00 ~ 0:00',
  `leaveOverworkId` bigint(20) DEFAULT NULL COMMENT '연장근무/휴가원 ID',
  `conformStage` char(1) DEFAULT NULL COMMENT '연장근무/휴가원 결제stage',
  `roundNo` char(18) DEFAULT NULL COMMENT '구매품의서RoundNo',
  PRIMARY KEY (`id`),
  KEY `FK_alarm_message_dept_data` (`dept_code`),
  KEY `FK_notice_message_job_order` (`job_order_id`),
  CONSTRAINT `FK_alarm_message_dept_data` FOREIGN KEY (`dept_code`) REFERENCES `dept_data` (`id`),
  CONSTRAINT `FK_notice_message_job_order` FOREIGN KEY (`job_order_id`) REFERENCES `job_order` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=133 DEFAULT CHARSET=utf8 COMMENT='알람메세지';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.over_work 구조 내보내기
CREATE TABLE IF NOT EXISTS `over_work` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '내부 ID',
  `title` varchar(128) NOT NULL COMMENT '연장근무 제목',
  `request_reason` varchar(256) DEFAULT NULL COMMENT '연장근무 요청 사유',
  `request_dept` char(2) NOT NULL COMMENT '요청자부서',
  `reg_date` date NOT NULL COMMENT '연장근무 등록 날짜',
  `request_usr` varchar(5) NOT NULL COMMENT '요청자',
  `request_date` date NOT NULL COMMENT '연장근무 날짜',
  `request_min` int(11) DEFAULT NULL COMMENT '연장근무 사용 시간(분단위)',
  `request_strtime` char(5) NOT NULL COMMENT '시작 시간',
  `request_endtime` char(5) NOT NULL COMMENT '종료 시간',
  `kind` enum('A','B') NOT NULL DEFAULT 'A' COMMENT '''A'' - 연장근무, ''B'' - 휴일근무',
  `kind_dept` enum('A','B') NOT NULL DEFAULT 'A' COMMENT '''A'' - 2층부서, ''B'' - 1층부서',
  `conform_stage` enum('R','M','J','C') NOT NULL DEFAULT 'R' COMMENT '''R'' - 본인결제완료, ''M'' - 팀장결제완료, ''J'' - 이사결제완료, ''C'' - 대표이사결제완료',
  `sign_r` varchar(256) NOT NULL COMMENT '본인 싸인 이미지 path',
  `sign_m` varchar(256) DEFAULT NULL COMMENT '팀장 싸인 이미지 path',
  `m_date` date DEFAULT NULL COMMENT '팀장결제 날짜',
  `sign_j` varchar(256) DEFAULT NULL COMMENT '이사 싸인 이미지 path',
  `j_date` date DEFAULT NULL COMMENT '이사결제 날짜',
  `sign_c` varchar(256) DEFAULT NULL COMMENT '대표이사 싸인 이미지 path',
  `c_date` date DEFAULT NULL COMMENT '대표이사이사결제 날짜',
  `complet` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '결제 완료 여부',
  `deleted` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '삭제 여부',
  `delete_reason` varchar(256) DEFAULT NULL COMMENT '삭제 사유',
  `delete_user_id` char(5) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='연장근무';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.partner_billing 구조 내보내기
CREATE TABLE IF NOT EXISTS `partner_billing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `partner_id` char(2) NOT NULL COMMENT '거래처 ID',
  `billing_name` varchar(50) DEFAULT NULL COMMENT '계산서 업체명',
  `billing_after` varchar(5) DEFAULT NULL COMMENT '결제 기준',
  `billing_day` varchar(5) DEFAULT NULL COMMENT '결제일',
  PRIMARY KEY (`id`),
  KEY `FK_partner_biling_billing_after_data` (`billing_after`),
  KEY `FK_partner_biling_billing_day_data` (`billing_day`),
  KEY `FK_partner_biling_partner` (`partner_id`),
  CONSTRAINT `FK_partner_biling_billing_after_data` FOREIGN KEY (`billing_after`) REFERENCES `billing_after_data` (`id`),
  CONSTRAINT `FK_partner_biling_billing_day_data` FOREIGN KEY (`billing_day`) REFERENCES `billing_day_data` (`id`),
  CONSTRAINT `FK_partner_biling_partner` FOREIGN KEY (`partner_id`) REFERENCES `customer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='거래처의 세금계산서 발행';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.pid_back 구조 내보내기
CREATE TABLE IF NOT EXISTS `pid_back` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `job_order_id` bigint(20) NOT NULL COMMENT '피드백 orderId',
  `job_purchase_id` bigint(20) DEFAULT NULL COMMENT 'job_purcahse ID',
  `job_design_drawing_id` bigint(20) DEFAULT NULL COMMENT '도면ID',
  `userId` char(5) NOT NULL COMMENT '작성자ID',
  `dept` char(2) NOT NULL COMMENT '작성한부서',
  `receive_dept` char(2) DEFAULT NULL COMMENT '요청받은부서',
  `title` varchar(128) NOT NULL COMMENT '제목',
  `body` text NOT NULL COMMENT '본문',
  `view` int(11) NOT NULL DEFAULT '0' COMMENT '조회수',
  `when_created` datetime NOT NULL COMMENT '작성 날짜',
  `when_updated` datetime NOT NULL COMMENT '최종 수정 날짜',
  `deleted` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '삭제 여부(Y/N)',
  `checking` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '요청받은 부서 체크 여부(Y/N)',
  `kind` enum('D','P') NOT NULL COMMENT 'D:도면 관련, P:구매품관련',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='피드백원장';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.pid_back_comment 구조 내보내기
CREATE TABLE IF NOT EXISTS `pid_back_comment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `pid_back_id` bigint(20) NOT NULL,
  `small_body` varchar(128) NOT NULL COMMENT '댓글내용',
  `when_created` datetime NOT NULL COMMENT '작성 날짜',
  `when_updated` datetime NOT NULL COMMENT '최종 수정 날짜',
  `userId` char(5) NOT NULL COMMENT '작성자ID',
  `deleted` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '삭제 여부(Y/N)',
  PRIMARY KEY (`id`),
  KEY `FK_pid_back_comment_pid` (`pid_back_id`),
  CONSTRAINT `FK_pid_back_comment_pid` FOREIGN KEY (`pid_back_id`) REFERENCES `pid_back` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='피드백댓글';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.popData 구조 내보내기
CREATE TABLE IF NOT EXISTS `popData` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` char(1) NOT NULL COMMENT '작업타입',
  `description` varchar(20) NOT NULL COMMENT 'title',
  `body` varchar(20) NOT NULL COMMENT 'body',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='안드로이드 팝업 종류';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.position_data 구조 내보내기
CREATE TABLE IF NOT EXISTS `position_data` (
  `id` varchar(20) NOT NULL,
  `level` int(11) NOT NULL DEFAULT '100' COMMENT '직급별 소트가 되도록 하기 위한 가중치',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='직급 목록 테이블';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.purchase_estimate 구조 내보내기
CREATE TABLE IF NOT EXISTS `purchase_estimate` (
  `estimate_request_id` char(20) NOT NULL COMMENT '견적코드',
  `job_order_id` bigint(20) NOT NULL COMMENT 'job_order ID',
  `job_purchase_id` bigint(20) NOT NULL COMMENT 'job_purcahse ID',
  `partner_id` char(5) NOT NULL COMMENT '견적업체 ID',
  `reg_date` datetime NOT NULL COMMENT '등록날짜',
  `description` varchar(128) NOT NULL COMMENT '품목',
  `maker` varchar(128) NOT NULL COMMENT 'maker',
  `model_no` varchar(128) NOT NULL COMMENT '모델NO',
  `material` varchar(50) DEFAULT NULL COMMENT '재질',
  `estimated_price` int(11) DEFAULT NULL COMMENT '견적가',
  `quantity` int(11) NOT NULL COMMENT '견적수량',
  `receive_date` date DEFAULT NULL COMMENT '납기일',
  `reg_user` char(5) NOT NULL COMMENT '견적등록자',
  `comment` varchar(150) DEFAULT NULL COMMENT '코멘트',
  `stockId` bigint(20) DEFAULT NULL COMMENT '재고사용ID',
  PRIMARY KEY (`estimate_request_id`,`job_order_id`,`job_purchase_id`),
  KEY `FK_purchase_estimate_job_order` (`job_order_id`),
  KEY `FK_purchase_estimate_job_purchase` (`job_purchase_id`),
  KEY `FK_purchase_estimate_job_partner` (`partner_id`),
  CONSTRAINT `FK_purchase_estimate_job_order` FOREIGN KEY (`job_order_id`) REFERENCES `job_order` (`id`),
  CONSTRAINT `FK_purchase_estimate_job_partner` FOREIGN KEY (`partner_id`) REFERENCES `job_partner` (`id`),
  CONSTRAINT `FK_purchase_estimate_job_purchase` FOREIGN KEY (`job_purchase_id`) REFERENCES `job_purchase` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='견적 원장';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.purchase_estimate_before 구조 내보내기
CREATE TABLE IF NOT EXISTS `purchase_estimate_before` (
  `estimate_request_id` char(20) NOT NULL COMMENT '견적코드',
  `job_order_id` bigint(20) NOT NULL COMMENT 'job_order ID',
  `job_purchase_id` bigint(20) NOT NULL COMMENT 'job_purcahse ID',
  `partner_id` char(5) NOT NULL COMMENT '견적업체 ID',
  `reg_date` datetime NOT NULL COMMENT '등록날짜',
  `description` varchar(128) NOT NULL COMMENT '품목',
  `maker` varchar(128) NOT NULL COMMENT 'maker',
  `model_no` varchar(128) NOT NULL COMMENT '모델NO',
  `material` varchar(50) DEFAULT NULL COMMENT '재질',
  `estimated_price` int(11) DEFAULT NULL COMMENT '견적가',
  `quantity` int(11) NOT NULL COMMENT '견적수량',
  `receive_date` date DEFAULT NULL COMMENT '납기일',
  `reg_user` char(5) NOT NULL COMMENT '견적등록자',
  `comment` varchar(150) DEFAULT NULL COMMENT '코멘트',
  `stockId` bigint(20) DEFAULT NULL COMMENT '사용재고ID',
  PRIMARY KEY (`estimate_request_id`,`job_order_id`,`job_purchase_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='견적메일 발송 전 가상 DB';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.purchase_issue 구조 내보내기
CREATE TABLE IF NOT EXISTS `purchase_issue` (
  `issue_request_id` char(20) NOT NULL COMMENT '발주코드',
  `job_order_id` bigint(20) NOT NULL COMMENT 'job_order ID',
  `job_purchase_id` bigint(20) NOT NULL COMMENT 'job_purcahse ID',
  `partner_id` char(5) NOT NULL COMMENT '발주업체 ID',
  `estimate_request_id` char(20) DEFAULT NULL COMMENT '견적코드',
  `model_no` varchar(128) NOT NULL COMMENT '모델NO',
  `maker` varchar(128) DEFAULT NULL COMMENT 'maker',
  `reg_date` datetime NOT NULL COMMENT '등록날짜',
  `receive_date` date NOT NULL COMMENT '납기일',
  `reg_user` char(5) NOT NULL COMMENT '발주등록자',
  `issue_price` int(11) DEFAULT NULL COMMENT '견적가',
  `quantity` int(11) NOT NULL COMMENT '발주수량',
  `issue_type` enum('B','C','H') NOT NULL DEFAULT 'B' COMMENT '발주 타입 ''B'' - 일반업체발주, ''C'' - 직접구매카드결제, ''H'' - 직접구매간이영수증',
  `cancle` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '발주 취소 여부',
  `cancle_reason` varchar(256) DEFAULT NULL COMMENT '발주 취소 사유',
  `statement` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '거래명세표등록여부',
  PRIMARY KEY (`issue_request_id`,`job_order_id`,`job_purchase_id`),
  KEY `FK_purchase_issue_job_order` (`job_order_id`),
  KEY `FK_purchase_issue_job_purchase` (`job_purchase_id`),
  KEY `FK_purchase_issue_job_partner` (`partner_id`),
  CONSTRAINT `FK_purchase_issue_job_order` FOREIGN KEY (`job_order_id`) REFERENCES `job_order` (`id`),
  CONSTRAINT `FK_purchase_issue_job_partner` FOREIGN KEY (`partner_id`) REFERENCES `job_partner` (`id`),
  CONSTRAINT `FK_purchase_issue_job_purchase` FOREIGN KEY (`job_purchase_id`) REFERENCES `job_purchase` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='발주 원장';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.purchase_issue_before 구조 내보내기
CREATE TABLE IF NOT EXISTS `purchase_issue_before` (
  `issue_request_id` char(20) NOT NULL COMMENT '발주코드',
  `job_order_id` bigint(20) NOT NULL COMMENT 'job_order ID',
  `job_purchase_id` bigint(20) NOT NULL COMMENT 'job_purcahse ID',
  `partner_id` char(5) NOT NULL COMMENT '발주업체 ID',
  `estimate_request_id` char(20) DEFAULT NULL COMMENT '견적코드',
  `model_no` varchar(128) NOT NULL COMMENT '모델NO',
  `maker` varchar(128) DEFAULT NULL COMMENT 'maker',
  `reg_date` datetime NOT NULL COMMENT '등록날짜',
  `receive_date` date NOT NULL COMMENT '납기일',
  `reg_user` char(5) NOT NULL COMMENT '발주등록자',
  `issue_price` int(11) DEFAULT NULL COMMENT '견적가',
  `quantity` int(11) NOT NULL COMMENT '발주수량',
  `issue_type` enum('B','C','H') NOT NULL DEFAULT 'B' COMMENT '발주 타입 ''B'' - 일반업체발주, ''C'' - 직접구매카드결제, ''H'' - 직접구매간이영수증',
  `cancle` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '발주 취소 여부',
  `cancle_reason` varchar(256) DEFAULT NULL COMMENT '발주 취소 사유',
  `statement` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '거래명세표등록여부',
  `stockId` bigint(20) DEFAULT NULL COMMENT '재고ID',
  `ab_quantity` int(11) DEFAULT NULL COMMENT '불출대기수량',
  PRIMARY KEY (`issue_request_id`,`job_order_id`,`job_purchase_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='발주메일 발송 전 가상 DB';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.registered_file 구조 내보내기
CREATE TABLE IF NOT EXISTS `registered_file` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `when_registered` datetime NOT NULL,
  `user_Id` varchar(5) NOT NULL COMMENT '업로드한 사람의 계정',
  `registered_section` varchar(20) NOT NULL COMMENT '''DIARY'',''DRAWING'', ''DELIVERY'' 등등 어디서 파일을 등록했는지 확인 용도의 내부 식별자',
  `file_category` enum('IMG','DOC','DRAWING','PPT','ETC') NOT NULL DEFAULT 'DOC' COMMENT '파일의 유형(이미지인지 문서 파일인지 등등)',
  `when_deleted` datetime DEFAULT NULL COMMENT '삭제 시각(null 은 삭제 안된 정상 파일)',
  `file_size` bigint(20) NOT NULL COMMENT '파일의 크기(바이트 단위)',
  `original_filename` varchar(256) DEFAULT NULL COMMENT '원 파일 이름(이미지 첨부는 파일 이름 저장 안함)',
  `hash` char(40) NOT NULL COMMENT '내부 파일 이름 겸 링크 노출용ID = SHA1(시각 + USER_ID + original_filename)',
  PRIMARY KEY (`id`),
  KEY `hash` (`hash`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='시스템에 업로드된 모든(도면?) 파일의 원장\r\nimages 와 차이는 파일 이름을 내려 주느냐 차이';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.role_data 구조 내보내기
CREATE TABLE IF NOT EXISTS `role_data` (
  `id` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='시스템에 존재하는 권한 목록';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.round_robin 구조 내보내기
CREATE TABLE IF NOT EXISTS `round_robin` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '내부 ID',
  `roundNo` char(18) NOT NULL COMMENT '품의서 건 별 NO yyMMddhhmmss-usrId',
  `job_design_drawing_Id` bigint(20) DEFAULT NULL COMMENT '구매 대상의 도면 식별자',
  `job_order_id` bigint(20) DEFAULT NULL COMMENT '구매 대상의 작업 지시 번호',
  `title` varchar(128) NOT NULL COMMENT '품의서 제목',
  `request_reason` varchar(256) DEFAULT NULL COMMENT '품의 요청 사유',
  `round_kind` enum('P','M') NOT NULL DEFAULT 'P' COMMENT '''P'' - 구매부관련구매품, ''M'' - 관리부관련구매품',
  `reg_date` date NOT NULL COMMENT '구매 품의서 등록 날짜',
  `request_dept` char(2) NOT NULL COMMENT '요청자부서',
  `request_usr` varchar(5) NOT NULL COMMENT '요청자',
  `request_date` date DEFAULT NULL COMMENT '납기 요청 날짜',
  `description` varchar(128) DEFAULT NULL,
  `model_no` varchar(128) NOT NULL,
  `maker` varchar(128) NOT NULL,
  `partner_id` char(5) DEFAULT NULL COMMENT '업체 ID',
  `customer_id` char(2) DEFAULT NULL COMMENT '고객 ID',
  `quantity` int(11) DEFAULT NULL,
  `spare` int(11) DEFAULT NULL,
  `price` int(11) NOT NULL DEFAULT '0' COMMENT '단가',
  `code` varchar(50) DEFAULT NULL,
  `comment` varchar(50) DEFAULT NULL,
  `remark` varchar(50) DEFAULT NULL,
  `design_file_no` bigint(20) DEFAULT NULL,
  `stage` enum('R','P','F') NOT NULL DEFAULT 'R' COMMENT '''R'' - 결제진행중, ''P'' - 구매요청, ''F'' - 구매LIST등록',
  `conform_stage` enum('R','M','P','J','C') NOT NULL DEFAULT 'R' COMMENT '''R'' - 본인결제완료, ''M'' - 팀장결제완료,''P'' - 구매결제완료, ''J'' - 재무이사결제완료, ''C'' - 대표이사결제완료',
  `sign_r` varchar(256) NOT NULL COMMENT '본인 싸인 이미지 path',
  `sign_m` varchar(256) DEFAULT NULL COMMENT '팀장 싸인 이미지 path',
  `m_date` date DEFAULT NULL COMMENT '팀장결제 날짜',
  `sign_p` varchar(256) DEFAULT NULL COMMENT '구매싸인 이미지path',
  `p_date` date DEFAULT NULL COMMENT '구매결제 날짜',
  `sign_j` varchar(256) DEFAULT NULL COMMENT '재무이사 싸인 이미지 path',
  `j_date` date DEFAULT NULL COMMENT '재무이사결제 날짜',
  `sign_c` varchar(256) DEFAULT NULL COMMENT '대표이사 싸인 이미지 path',
  `c_date` date DEFAULT NULL COMMENT '대표이사이사결제 날짜',
  `order_request_id` char(20) DEFAULT NULL,
  `order_requested_when` datetime DEFAULT NULL,
  `order_request_user_id` char(5) DEFAULT NULL,
  `deleted` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '삭제 여부',
  `delete_reason` varchar(256) DEFAULT NULL COMMENT '삭제 사유',
  `delete_user_id` char(5) DEFAULT NULL,
  `warehousing_quantity` int(11) DEFAULT NULL COMMENT '입고수량',
  `warehousing_user` varchar(5) DEFAULT NULL COMMENT '입고자',
  `warehousing_date` date DEFAULT NULL COMMENT '입고날짜',
  `pass_date` date DEFAULT NULL COMMENT '불출날짜',
  `pass_usr` varchar(5) DEFAULT NULL COMMENT '인계자',
  `receiver_usr` varchar(5) DEFAULT NULL COMMENT '인수자',
  `receive_dept` char(2) DEFAULT NULL COMMENT '입고부서',
  `out_quantity` int(11) DEFAULT NULL COMMENT '반품수량',
  `out_user` varchar(5) DEFAULT NULL COMMENT '반품자',
  `out_reason` text COMMENT '반품사유',
  `statement_type` enum('A','X','S') NOT NULL DEFAULT 'X' COMMENT '''A'' - 전체등록 완료, ''X'' - 전체등록 미완료, ''S'' - 부분등록',
  `stock_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '재고등록 수량',
  `stock_use_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '재고사용 수량',
  PRIMARY KEY (`id`),
  KEY `FK_round_robin_job_design_drawing` (`job_design_drawing_Id`),
  KEY `round_robin_stage` (`stage`),
  KEY `FK_round_robin_job_partner` (`partner_id`),
  KEY `FK_round_robin_job_order` (`job_order_id`),
  KEY `round_robin_deleted` (`deleted`),
  CONSTRAINT `FK_round_robin_job_design_drawing` FOREIGN KEY (`job_design_drawing_Id`) REFERENCES `job_design_drawing` (`id`),
  CONSTRAINT `FK_round_robin_job_order` FOREIGN KEY (`job_order_id`) REFERENCES `job_order` (`id`),
  CONSTRAINT `FK_round_robin_job_partner` FOREIGN KEY (`partner_id`) REFERENCES `job_partner` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COMMENT='구매품의서 원장';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.statement_of_account 구조 내보내기
CREATE TABLE IF NOT EXISTS `statement_of_account` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `issue_date` date NOT NULL COMMENT '거래명세 발행날짜 - 수기로 등록날짜 변경 가능(NOW 아님)',
  `partner_type_kind` enum('P','S','M') NOT NULL COMMENT 'P:구매, S:가공, M:관리 구분필드',
  `partner_id` char(5) NOT NULL COMMENT '업체코드=업체대분류(type_code) + 업체소분류(type_kind) + 3자리 순번',
  `reg_datetime` datetime NOT NULL COMMENT '거래명세 등록 날짜',
  `request_id` varchar(50) NOT NULL COMMENT '구매/가공/관리 발주NO (이름변경필요)',
  `job_order_id` bigint(20) NOT NULL COMMENT '설비/치공구 작업원장ID - NULL인경우도 있을 수 있음(잡자재 구매시)',
  `sum_price` bigint(20) DEFAULT NULL COMMENT '거래명세 전체 합계',
  `nego_price` bigint(20) NOT NULL DEFAULT '0' COMMENT '거래명세 negotiations(네고) 금액 ',
  `buy_kind` enum('B','H','C') DEFAULT NULL COMMENT 'B:계산서, H:간이영수증, C:카드결제',
  PRIMARY KEY (`id`),
  KEY `partner_id_job_order_id` (`partner_id`,`job_order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8 COMMENT='거래명세표 원장';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.statement_of_account_detail 구조 내보내기
CREATE TABLE IF NOT EXISTS `statement_of_account_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `issue_id` bigint(20) NOT NULL COMMENT '거래명세서 ID',
  `job_design_drawing_id` bigint(20) DEFAULT NULL COMMENT '도면 원장 ID',
  `job_outsourcing_order_uid` bigint(20) DEFAULT NULL COMMENT '가공발주 UID',
  `job_purchase_id` bigint(20) DEFAULT NULL COMMENT '구매 원장 ID',
  `job_management_id` bigint(20) DEFAULT NULL COMMENT '관리부 구매 원장 ID',
  `issued_item_name` varchar(128) DEFAULT NULL COMMENT '거래명세서에 기재된 품명',
  `modelNo` varchar(128) DEFAULT NULL COMMENT '거래명세서에 기재된 ModelNo',
  `issued_quantity` int(11) DEFAULT NULL COMMENT '거래명세서에 기재된 수량',
  `issued_unit_price` int(11) DEFAULT NULL COMMENT '거래명세서에 기재된 단가',
  PRIMARY KEY (`id`),
  KEY `FK_statement_of_account` (`issue_id`),
  CONSTRAINT `FK_statement_of_account` FOREIGN KEY (`issue_id`) REFERENCES `statement_of_account` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8 COMMENT='거래명세표 리스트';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.stock 구조 내보내기
CREATE TABLE IF NOT EXISTS `stock` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '재고 ID',
  `job_purchase_id` bigint(20) DEFAULT NULL,
  `request_id` char(22) DEFAULT NULL COMMENT '요청ID',
  `model_no` varchar(128) NOT NULL COMMENT 'MODEL No/SIZE',
  `maker` varchar(128) NOT NULL COMMENT 'Maker',
  `description` varchar(128) DEFAULT NULL,
  `issue_price` int(11) DEFAULT NULL COMMENT '발주가',
  `quantity` int(11) NOT NULL COMMENT '재고수량',
  `ab_quantity` int(11) DEFAULT '0' COMMENT '불출대기수량',
  `out_quantity` int(11) DEFAULT NULL COMMENT '불출수량',
  `deleted` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '재고삭제여부',
  `final_date` date DEFAULT NULL COMMENT '최종재고등록및불출날짜',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=582 DEFAULT CHARSET=utf8 COMMENT='재고';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.stock_in_histroy 구조 내보내기
CREATE TABLE IF NOT EXISTS `stock_in_histroy` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '내부 ID',
  `stockID` bigint(20) NOT NULL COMMENT '재고 ID',
  `registration_date` date NOT NULL COMMENT '재고등록날짜',
  `registration_user` varchar(5) DEFAULT NULL COMMENT '재고등록자',
  `registration_reason` text COMMENT '재고등록사유',
  `stock_able` enum('Y','N') DEFAULT NULL COMMENT '재고 신품Y,불용N 여부',
  `in_quantity` int(11) DEFAULT NULL COMMENT '등록수량',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='재고등록기록';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.stock_out_histroy 구조 내보내기
CREATE TABLE IF NOT EXISTS `stock_out_histroy` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '내부 ID',
  `stockID` bigint(20) NOT NULL COMMENT '재고 ID',
  `pass_date` date DEFAULT NULL COMMENT '불출날짜',
  `pass_user` varchar(5) DEFAULT NULL COMMENT '불출자',
  `receive_dept` char(2) DEFAULT NULL COMMENT '수령부서',
  `receiver_usr` varchar(5) DEFAULT NULL COMMENT '수령자',
  `out_quantity` int(11) DEFAULT NULL COMMENT '불출수량',
  `out_reason` text COMMENT '불출사유',
  `job_order_id` bigint(20) NOT NULL COMMENT 'OrderId',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COMMENT='재고불출기록';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.system_config 구조 내보내기
CREATE TABLE IF NOT EXISTS `system_config` (
  `code` varchar(50) NOT NULL,
  `val` varchar(50) NOT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='설정';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.transition_processing 구조 내보내기
CREATE TABLE IF NOT EXISTS `transition_processing` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `preId` bigint(20) NOT NULL DEFAULT '0' COMMENT '재인계 직전 ID',
  `job_order_id` bigint(20) NOT NULL COMMENT 'job_order ID',
  `kind_repass` enum('A','P') DEFAULT NULL COMMENT '재인계 종류 ''A'' - 일반인계, ''P'' - 불량및파손',
  `job_design_drawing_id` bigint(20) NOT NULL COMMENT '도면 원장 ID',
  `pass_usr` char(5) NOT NULL COMMENT '인계자',
  `receive_dept` char(2) NOT NULL COMMENT '인수받은부서',
  `receiver_usr` char(5) DEFAULT NULL COMMENT '인수자',
  `complet` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '인수완료 여부',
  `reYN` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '재인계여부',
  `quantity` int(11) NOT NULL DEFAULT '0' COMMENT '인수수량',
  `rquantity` int(11) NOT NULL DEFAULT '0' COMMENT '불출수량',
  `reReason` varchar(128) DEFAULT NULL COMMENT '재인계사유',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COMMENT='가공인수인계현황';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.transition_purchase 구조 내보내기
CREATE TABLE IF NOT EXISTS `transition_purchase` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `preId` bigint(20) NOT NULL DEFAULT '0' COMMENT '재인계 직전 ID',
  `job_order_id` bigint(20) NOT NULL COMMENT 'job_order ID',
  `job_purchase_id` bigint(20) DEFAULT NULL COMMENT 'job_purcahse ID',
  `kind_purchase` enum('P','S') NOT NULL COMMENT ' 입고구매품/재고구매품 종류 ''P'' - 입고구매품, ''S'' - 재고구매품',
  `kind_repass` enum('A','P') DEFAULT NULL COMMENT ' 재인계 종류 ''A'' - 일반인계, ''P'' - 불량및파손',
  `stockId` bigint(20) DEFAULT NULL COMMENT '재고 ID',
  `stock_history_id` bigint(20) DEFAULT NULL COMMENT 'stock history ID',
  `pass_usr` char(5) NOT NULL COMMENT '인계자',
  `receive_dept` char(2) NOT NULL COMMENT '인수받은부서',
  `receiver_usr` char(5) DEFAULT NULL COMMENT '인수자',
  `complet` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '인수완료 여부',
  `abstock` enum('Y','N') DEFAULT 'N' COMMENT '불출대기수량불출여부(재고품)',
  `reYN` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '재인계여부',
  `quantity` int(11) NOT NULL DEFAULT '0' COMMENT '인수수량',
  `rquantity` int(11) NOT NULL DEFAULT '0' COMMENT '불출수량',
  `reReason` varchar(128) DEFAULT NULL COMMENT '재인계사유',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8 COMMENT='구매인수인계현황';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.user 구조 내보내기
CREATE TABLE IF NOT EXISTS `user` (
  `id` char(5) NOT NULL COMMENT '로그인 계정 (숫자 5자리)',
  `kakao_Id` varchar(50) NOT NULL COMMENT '카카오톡 ID',
  `email` varchar(50) NOT NULL COMMENT '이메일',
  `password` varchar(40) NOT NULL COMMENT '비밀번호(SHA1)',
  `name` varchar(20) NOT NULL COMMENT '이름',
  `eng_name` varchar(20) NOT NULL COMMENT '영문이름',
  `dept_code` char(2) NOT NULL COMMENT '부서코드',
  `position` varchar(20) NOT NULL COMMENT '직위',
  `in_phone` varchar(4) NOT NULL COMMENT '내선번호',
  `direct_phone` varchar(15) NOT NULL COMMENT '직통번호',
  `hand_phone` varchar(15) NOT NULL COMMENT '휴대폰',
  `home_phone` varchar(15) DEFAULT NULL COMMENT '집 또는 보호자번호',
  `home_address` varchar(128) NOT NULL COMMENT '집주소',
  `join_date` date NOT NULL COMMENT '입사일',
  `quit_date` date DEFAULT NULL COMMENT '퇴사일',
  `passport_expire_date` date DEFAULT NULL COMMENT '여권 만료일',
  `last_login` date DEFAULT NULL COMMENT '마지막 로그인시간',
  `view_index` int(11) NOT NULL COMMENT '메인화면 연락처 순번',
  `is_manager` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '팀장 여부',
  `is_factory_manager` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '공장장 여부',
  `is_director` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '재무이사 여부',
  `is_ceo` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '대표이사 여부',
  `is_admin` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '관리자 여부',
  `is_qc` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '검사(QC)담당자',
  `is_pgm` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '프로그램 담당자',
  `is_robot` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '로봇티칭 담당자',
  `mct_passwd` char(4) DEFAULT NULL COMMENT '가공 프로그램 구동 비밀번호(숫자4자리)',
  `is_out` enum('Y','N') DEFAULT 'N' COMMENT '퇴사여부',
  `hour_count` int(11) NOT NULL DEFAULT '0' COMMENT '연차시간',
  `baseHourCount` int(11) NOT NULL DEFAULT '0' COMMENT '기초연차시간',
  `bankId` bigint(20) DEFAULT '0' COMMENT '은행ID',
  `accountNo` varchar(50) DEFAULT '0' COMMENT '급여계좌번호',
  PRIMARY KEY (`id`),
  KEY `FK_user_dept` (`dept_code`),
  KEY `FK_user_position` (`position`),
  CONSTRAINT `FK_user_dept` FOREIGN KEY (`dept_code`) REFERENCES `dept_data` (`id`),
  CONSTRAINT `FK_user_position` FOREIGN KEY (`position`) REFERENCES `position_data` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='직원 테이블';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.user_commute 구조 내보내기
CREATE TABLE IF NOT EXISTS `user_commute` (
  `user_id` char(5) NOT NULL COMMENT '직원ID',
  `commmute_date` date NOT NULL COMMENT '출퇴근 등록 날짜',
  `commmute_start` datetime DEFAULT NULL COMMENT '출근 시간',
  `commmute_end` datetime DEFAULT NULL COMMENT '퇴근 시간',
  `trip_yn` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '출장여부 Y:출장, N:회사출근',
  `order_id` bigint(20) DEFAULT NULL COMMENT 'job_order 테이블 id',
  `setup_id` bigint(20) DEFAULT NULL COMMENT 'job_setup 테이블 id',
  PRIMARY KEY (`user_id`,`commmute_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='직원 출퇴근 원장';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.user_leave_application 구조 내보내기
CREATE TABLE IF NOT EXISTS `user_leave_application` (
  `user_id` char(5) NOT NULL COMMENT '로그인 계정 (숫자 5자리)',
  `hour_count` int(11) NOT NULL DEFAULT '0' COMMENT '연차시간',
  `dept_code` char(2) NOT NULL COMMENT '부서',
  PRIMARY KEY (`user_id`),
  KEY `FK_user_leave_application_user_id` (`user_id`),
  CONSTRAINT `FK_user_leave_application_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='직원 연차 수량';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.user_menu_mapping 구조 내보내기
CREATE TABLE IF NOT EXISTS `user_menu_mapping` (
  `user_id` char(5) NOT NULL,
  `high_code` char(2) NOT NULL,
  `low_code` char(2) NOT NULL,
  `list_code` char(2) NOT NULL COMMENT '하위 메뉴 리스트 코드(''00'' : 상위 메뉴)',
  `visible` enum('Y','N') NOT NULL,
  `updateYN` enum('Y','N') NOT NULL,
  PRIMARY KEY (`user_id`,`high_code`,`low_code`,`list_code`),
  KEY `FK_menu_user` (`user_id`),
  KEY `FK_user_menu_mapping_menu_data` (`high_code`,`low_code`,`list_code`),
  CONSTRAINT `FK_menu_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_user_menu_mapping_menu_data` FOREIGN KEY (`high_code`, `low_code`, `list_code`) REFERENCES `menu_data` (`high_code`, `low_code`, `list_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='이용자별 메뉴 맵핑';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.user_role_mapping 구조 내보내기
CREATE TABLE IF NOT EXISTS `user_role_mapping` (
  `user_id` char(5) NOT NULL,
  `role_id` varchar(30) NOT NULL,
  UNIQUE KEY `userId_role` (`user_id`,`role_id`),
  KEY `FK_privilege_role` (`role_id`),
  CONSTRAINT `FK_privilege_role` FOREIGN KEY (`role_id`) REFERENCES `role_data` (`id`),
  CONSTRAINT `FK_privilege_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='개별 이용자 권한 맵핑';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.user_sign_img 구조 내보내기
CREATE TABLE IF NOT EXISTS `user_sign_img` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` char(5) NOT NULL COMMENT '직원ID',
  `dept_code` char(2) NOT NULL COMMENT '부서코드',
  `position` varchar(20) NOT NULL COMMENT '직위',
  `sign_img_path` varchar(256) NOT NULL COMMENT '싸인이미지path',
  PRIMARY KEY (`id`),
  KEY `FK_user_sign_img_user_id` (`user_id`),
  KEY `FK_user_sign_img_dept` (`dept_code`),
  KEY `FK_user_sign_position` (`position`),
  CONSTRAINT `FK_user_sign_img_dept` FOREIGN KEY (`dept_code`) REFERENCES `dept_data` (`id`),
  CONSTRAINT `FK_user_sign_img_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_user_sign_position` FOREIGN KEY (`position`) REFERENCES `position_data` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='직원싸인이미지';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.work_manager 구조 내보내기
CREATE TABLE IF NOT EXISTS `work_manager` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '내부 ID',
  `usr_id` char(5) NOT NULL COMMENT 'userID',
  `dept_code` char(2) NOT NULL COMMENT '부서코드',
  `registration_date` date NOT NULL COMMENT '날짜',
  `commmute_start` time DEFAULT NULL COMMENT '출근 시간',
  `commmute_end` time DEFAULT NULL COMMENT '퇴근 시간',
  `startkind` enum('G','E','H','D') NOT NULL COMMENT 'G:정상출근, E:자료없음, H:휴일출근, D:결근',
  `endkind` enum('G','E','H','D') NOT NULL COMMENT 'G:정상퇴근, E:자료없음, H:휴일퇴근, D:결근',
  `overWork` time DEFAULT NULL COMMENT '연장 근무 시간',
  `nightWork` time DEFAULT NULL COMMENT '야간 근무 시간',
  `holidayWork` time DEFAULT NULL COMMENT '휴일 근무 시간',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COMMENT='근태관리원장';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.work_trip 구조 내보내기
CREATE TABLE IF NOT EXISTS `work_trip` (
  `user_id` char(5) NOT NULL COMMENT '출장자 ID',
  `customer_id` char(5) NOT NULL COMMENT '출장 고객사',
  `work_date` date NOT NULL COMMENT '출장 출근 날짜',
  `work_start` datetime NOT NULL COMMENT '출장 출근 시간',
  `work_end` datetime DEFAULT NULL COMMENT '출장 퇴근 시간',
  `order_id` bigint(20) DEFAULT NULL COMMENT 'job_order 테이블 id',
  `manual_order_id` varchar(100) DEFAULT NULL COMMENT '수기로 작성한 order full code',
  `overseas_yn` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '해외 출장여부 Y:해외, N:국내',
  PRIMARY KEY (`user_id`,`customer_id`,`work_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='직원 출장 원장';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 yuhan_erp_2.___unused___job_partner_order_request 구조 내보내기
CREATE TABLE IF NOT EXISTS `___unused___job_partner_order_request` (
  `id` char(16) NOT NULL COMMENT '발주번호 CCCCC-HHMMDD-DDD (하이픈 포함 16자리)',
  `job_design_drawing_id` bigint(20) NOT NULL COMMENT '도면ID',
  `outsourcing_partner_id` char(5) NOT NULL COMMENT '외주 가공 업체ID',
  `due_date` date NOT NULL COMMENT '납기일',
  `order_unit_price` int(11) NOT NULL COMMENT '발주 단가',
  `file_url` varchar(256) NOT NULL COMMENT '도면 파일 URL',
  `withCoating` enum('Y','N') DEFAULT NULL COMMENT '후처리 요청',
  PRIMARY KEY (`id`,`job_design_drawing_id`),
  KEY `FK_job_partner_order_request_buy_partner` (`outsourcing_partner_id`),
  CONSTRAINT `FK_job_partner_order_request_buy_partner` FOREIGN KEY (`outsourcing_partner_id`) REFERENCES `job_partner` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='외주 발주요청';

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 트리거 yuhan_erp_2.concept_job_order_after_update_trigger 구조 내보내기
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `concept_job_order_after_update_trigger` AFTER UPDATE ON `concept_job_order` FOR EACH ROW BEGIN
	
	declare JobOrderModificationID bigint;
	
	
	if NEW.deleted = 'N' then 

		
		insert into job_order_modification_history (job_order_id, source_category, change_type, user_id, when_modified)
			values (  OLD.id, 'CONCEPT', 'CHANGE', NEW.last_modified_user_id, now() );
		set @JobOrderModificationID = LAST_INSERT_ID();
	
		
		if old.device <> new.device then
			insert into job_order_modified_value (job_order_change_id, field_name, `before`, `after`) values( @JobOrderModificationID, 'device', old.device, new.device);
		end if;
		if old.business_user_id <> new.business_user_id then
			insert into job_order_modified_value (job_order_change_id, field_name, `before`, `after`) values( @JobOrderModificationID, 'business_user_id', old.business_user_id, new.business_user_id);
		end if;
		if old.design_user_id <> new.design_user_id then
			insert into job_order_modified_value (job_order_change_id, field_name, `before`, `after`) values( @JobOrderModificationID, 'design_user_id', old.design_user_id, new.design_user_id);
		end if;
		if old.customer_user <> new.customer_user then
			insert into job_order_modified_value (job_order_change_id, field_name, `before`, `after`) values( @JobOrderModificationID, 'customer_user', old.customer_user, new.customer_user);
		end if;
		if old.quantity <> new.quantity then
			insert into job_order_modified_value (job_order_change_id, field_name, `before`, `after`) values( @JobOrderModificationID, 'quantity', old.quantity, new.quantity);
		end if;
		if old.internal_unit_price <> new.internal_unit_price then
			insert into job_order_modified_value (job_order_change_id, field_name, `before`, `after`) values( @JobOrderModificationID, 'internal_unit_price', old.internal_unit_price, new.internal_unit_price);
		end if;
	
		if old.estimated_price <> new.estimated_price or (old.estimated_price is null and new.estimated_price is not null) then
			insert into job_order_modified_value (job_order_change_id, field_name, `before`, `after`) values( @JobOrderModificationID, 'estimated_price', old.estimated_price, new.estimated_price);
		end if;
		if old.negotiated_price <> new.negotiated_price or (old.negotiated_price is null and new.negotiated_price is not null)  then
			insert into job_order_modified_value (job_order_change_id, field_name, `before`, `after`) values( @JobOrderModificationID, 'negotiated_price', old.negotiated_price, new.negotiated_price);
		end if;
		if old.internal_price_file_no <> new.internal_price_file_no or (old.internal_price_file_no is null and new.internal_price_file_no is not null)  then
			insert into job_order_modified_value (job_order_change_id, field_name, `before`, `after`) values( @JobOrderModificationID, 'internal_price_file_no', old.internal_price_file_no, new.internal_price_file_no);
		end if;
		if old.concept_file_no <> new.concept_file_no or (old.concept_file_no is null and new.concept_file_no is not null)  then
			insert into job_order_modified_value (job_order_change_id, field_name, `before`, `after`) values( @JobOrderModificationID, 'concept_file_no', old.concept_file_no, new.concept_file_no);
		end if;
		if old.internal_unit_price_shared_date <> new.internal_unit_price_shared_date or (old.internal_unit_price_shared_date is null and new.internal_unit_price_shared_date is not null)  then
			insert into job_order_modified_value (job_order_change_id, field_name, `before`, `after`) values( @JobOrderModificationID, 'internal_unit_price_shared_date', old.internal_unit_price_shared_date, new.internal_unit_price_shared_date);
		end if;
	

	else

		
		insert into job_order_modification_history (job_order_id, source_category, change_type, user_id, when_modified)
			values (  OLD.id, 'CONCEPT', 'DELETE', NEW.last_modified_user_id, now() );
	
	end if;		
	
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- 트리거 yuhan_erp_2.job_order_after_update_trigger 구조 내보내기
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `job_order_after_update_trigger` AFTER UPDATE ON `job_order` FOR EACH ROW BEGIN
	
	declare JobOrderModificationID bigint;
	
	
	if NEW.deleted = 'N' then 

		
		insert into job_order_modification_history (job_order_id, source_category, change_type, user_id, when_modified)
			values (  OLD.id, 'ORDER', 'CHANGE', NEW.last_modified_user_id, now() );
		set @JobOrderModificationID = LAST_INSERT_ID();
	
		
		if old.device <> new.device then
			insert into job_order_modified_value (job_order_change_id, field_name, `before`, `after`) values( @JobOrderModificationID, 'device', old.device, new.device);
		end if;
		if old.business_user_id <> new.business_user_id then
			insert into job_order_modified_value (job_order_change_id, field_name, `before`, `after`) values( @JobOrderModificationID, 'business_user_id', old.business_user_id, new.business_user_id);
		end if;
		if old.design_user_id <> new.design_user_id then
			insert into job_order_modified_value (job_order_change_id, field_name, `before`, `after`) values( @JobOrderModificationID, 'design_user_id', old.design_user_id, new.design_user_id);
		end if;
		if old.customer_user <> new.customer_user then
			insert into job_order_modified_value (job_order_change_id, field_name, `before`, `after`) values( @JobOrderModificationID, 'customer_user', old.customer_user, new.customer_user);
		end if;
		if old.estimated_days <> new.estimated_days then
			insert into job_order_modified_value (job_order_change_id, field_name, `before`, `after`) values( @JobOrderModificationID, 'estimated_days', old.estimated_days, new.estimated_days);
		end if;
		if old.quantity <> new.quantity then
			insert into job_order_modified_value (job_order_change_id, field_name, `before`, `after`) values( @JobOrderModificationID, 'quantity', old.quantity, new.quantity);
		end if;
		if old.internal_unit_price <> new.internal_unit_price then
			insert into job_order_modified_value (job_order_change_id, field_name, `before`, `after`) values( @JobOrderModificationID, 'internal_unit_price', old.internal_unit_price, new.internal_unit_price);
		end if;
	
		if old.estimated_price <> new.estimated_price or (old.estimated_price is null and new.estimated_price is not null) then
			insert into job_order_modified_value (job_order_change_id, field_name, `before`, `after`) values( @JobOrderModificationID, 'estimated_price', old.estimated_price, new.estimated_price);
		end if;
		if old.negotiated_price <> new.negotiated_price or (old.negotiated_price is null and new.negotiated_price is not null)  then
			insert into job_order_modified_value (job_order_change_id, field_name, `before`, `after`) values( @JobOrderModificationID, 'negotiated_price', old.negotiated_price, new.negotiated_price);
		end if;
		if old.internal_price_file_no <> new.internal_price_file_no or (old.internal_price_file_no is null and new.internal_price_file_no is not null)  then
			insert into job_order_modified_value (job_order_change_id, field_name, `before`, `after`) values( @JobOrderModificationID, 'internal_price_file_no', old.internal_price_file_no, new.internal_price_file_no);
		end if;
		if old.concept_file_no <> new.concept_file_no or (old.concept_file_no is null and new.concept_file_no is not null)  then
			insert into job_order_modified_value (job_order_change_id, field_name, `before`, `after`) values( @JobOrderModificationID, 'concept_file_no', old.concept_file_no, new.concept_file_no);
		end if;
		if old.internal_unit_price_shared_date <> new.internal_unit_price_shared_date or (old.internal_unit_price_shared_date is null and new.internal_unit_price_shared_date is not null)  then
			insert into job_order_modified_value (job_order_change_id, field_name, `before`, `after`) values( @JobOrderModificationID, 'internal_unit_price_shared_date', old.internal_unit_price_shared_date, new.internal_unit_price_shared_date);
		end if;
		if old.shipping_date <> new.shipping_date  or (old.shipping_date is null and new.shipping_date is not null)  then
			insert into job_order_modified_value (job_order_change_id, field_name, `before`, `after`) values( @JobOrderModificationID, 'shipping_date', old.shipping_date, new.shipping_date);
		end if;
	
		if old.delivery_date <> new.delivery_date  or (old.delivery_date is null and new.delivery_date is not null)  then
			insert into job_order_modified_value (job_order_change_id, field_name, `before`, `after`) values( @JobOrderModificationID, 'delivery_date', old.delivery_date, new.delivery_date);
		end if;
		if old.test_date <> new.test_date or (old.test_date is null and new.test_date is not null)  then
			insert into job_order_modified_value (job_order_change_id, field_name, `before`, `after`) values( @JobOrderModificationID, 'test_date', old.test_date, new.test_date);
		end if;
		if old.install_date <> new.install_date or (old.install_date is null and new.install_date is not null)  then
			insert into job_order_modified_value (job_order_change_id, field_name, `before`, `after`) values( @JobOrderModificationID, 'install_date', old.install_date, new.install_date);
		end if;
		if old.real_install_date <> new.real_install_date or (old.real_install_date is null and new.real_install_date is not null)  then
			insert into job_order_modified_value (job_order_change_id, field_name, `before`, `after`) values( @JobOrderModificationID, 'real_install_date', old.real_install_date, new.real_install_date);
		end if;
		if old.design_progress <> new.design_progress then
			insert into job_order_modified_value (job_order_change_id, field_name, `before`, `after`) values( @JobOrderModificationID, 'design_progress', old.design_progress, new.design_progress);
		end if;
		if old.design_date <> new.design_date or (old.design_date is null and new.design_date is not null)  then
			insert into job_order_modified_value (job_order_change_id, field_name, `before`, `after`) values( @JobOrderModificationID, 'shipping_date', old.design_date, new.design_date);
		end if;

	else

		
		insert into job_order_modification_history (job_order_id, source_category, change_type, user_id, when_modified)
			values (  OLD.id, 'ORDER', 'DELETE', NEW.last_modified_user_id, now() );
	
	end if;		
	
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
