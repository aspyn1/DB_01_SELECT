--1. 영어영문학과(학과코드 002)학생들의 학번과 이름, 입학년도를 
-- 입학년도가 빠른 순으로 표시하는 SQL문장을 작성해라
-- 헤더는 "학번", "이름", "입학년도"로 표기

SELECT STUDENT_NO 학번, STUDENT_NAME 이름, ENTRANCE_DATE 입학년도
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '002'
ORDER BY STUDENT_NO;

--2. 춘 기술대학교의 교수 중 이름이 세글자가 아닌 교수가 한 명 있다.
-- 교수의 이름과 주민번호를 출력해라
SELECT PROFESSOR_NAME, PROFESSOR_SSN  
FROM TB_PROFESSOR 
WHERE PROFESSOR_NAME NOT LIKE '___';

-- 3. 남자 교수들의 이름과 나이를 출력하는 문장을 작성해라
-- 단, 나이가 적은 사람에서 많은 사람 순서로 화면에 출력해라
-- 2000년 이후 출생자는 없으며, 출력헤더는 "교수이름", "나이"로 출력하고, 나이는 만으로 계산한다.

SELECT PROFESSOR_NAME 교수이름, SUBSTR(PROFESSOR_SSN, 0, 2) -23 나이
FROM TB_PROFESSOR
WHERE SUBSTR( PROFESSOR_SSN, 8 , 1 ) = '1'
ORDER BY PROFESSOR_SSN;

-- 4. 교수들의 이름 중 성을 제외한 이름만 출력하는 문장을 작성해라. 
-- 헤더는 "이름으로 작성, 성이 2자인 경우의 교수는 없다고 가정
SELECT SUBSTR(PROFESSOR_NAME, 2, 2) 
FROM TB_PROFESSOR;

-- 5. 춘 기술대학교의 재수생 입학자를 구하려고한다. 
-- 단, 19살에 입학하면 재수하지않은 것으로 간주

SELECT STUDENT_NO, STUDENT_NAME  
FROM TB_STUDENT
-- WHERE SUBSTR( ENTRANCE_DATE , 0, 4 ) - SUBSTR( STUDENT_SSN, 0, 2 ) > 19;


-- 6. 2020년 크리스마스는 무슨 요일인가?
-- SELECT TO_DATE('201231', 'YYMMDD (DY)') FROM DUAL;


-- 7. TO_DATE('99/10/11', 'YY/MM/DD'), TO_DATE('49/10/11', 'YY/MM/DD')은 각각 몇년 몇월 몇일을 의미하는가
-- 또 TO_DATE('99/10/11', 'RR/MM/DD'), TO_DATE('49/10/11', 'RR/MM/DD')은 각각  몇년 몇월 몇일을 의미하는가
SELECT TO_DATE('99/10/11', 'YY/MM/DD'), TO_DATE('49/10/11', 'YY/MM/DD')
FROM DUAL; -- 2099-10-11 00:00:00.000 / 2049-10-11 00:00:00.000

SELECT TO_DATE('99/10/11', 'RR/MM/DD'), TO_DATE('49/10/11', 'RR/MM/DD')
FROM DUAL; -- 1999-10-11 00:00:00.000	2049-10-11 00:00:00.000

-- 8. 2000년도 이후 입학자들은 학번이 A로 시작하게 되어있다.
-- 2000년도 이전 학번을 받은 학생들의 학번과 이름을 보여달라
SELECT STUDENT_NO, STUDENT_NAME 
FROM TB_STUDENT
WHERE SUBSTR( STUDENT_NO, 0, 1)  != 'A';


-- 9. 학번이 A517178인 한아름 학생의 학점 총 평점을 구하는 SQL문을 만드시오
-- 헤더는 "평점"이라고 작성하고, 점수는 반올림하여 소수점 이하 한자리만 표시
SELECT ROUND(AVG(POINT) , 1)  평점
FROM TB_GRADE
WHERE STUDENT_NO = 'A517178';

-- 10. 학과별 학생수를 구하여 "학과번호", "학생수(명)"의 형태로 헤더를 만들어 출력해라
SELECT DEPARTMENT_NO "학과번호", COUNT(*) "학생수(명)"
FROM TB_STUDENT GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO;


-- 11. 지도 교수를 배정받지 못한 학생의 수는 몇 명 정도 되는지 알아내라
SELECT COUNT(*) 
FROM TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL;

-- 12. 학번이 A112113인 김고운 학생의 년도 별 평점을 구하는 SQL문을 작성해라.
-- 단, 헤더는 "년도", "년도 별 평점"으로 나타내고, 점수는 반올림해 소수점 1자리까지 표시
SELECT SUBSTR(TERM_NO, 0, 4) "년도", ROUND( AVG(POINT), 1) "년도 별 평점" 
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO, 0, 4) ;


-- 13. 학과 별 휴학생 수를 파악하고자 한다. 학과번호와 휴학생 수를 나타내라

SELECT DEPARTMENT_NO  "학과코드명", COUNT(*) "휴학생 수" 
FROM TB_STUDENT
WHERE ABSENCE_YN = 'N'
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO ;


-- 14. 춘 대학교에 다니는 동명이인 학생들의 이름을 찾아라
SELECT STUDENT_NAME "동일이름", COUNT(*) "동명인 수" 
FROM TB_STUDENT
GROUP BY STUDENT_NAME
HAVING COUNT(*) > 1
ORDER BY STUDENT_NAME;

-- 15. 학번이 A112113인 김고운 학생의 년도, 학기 별 평점과
-- 년도 별 누적 평점, 총 평점을 구해라. 평점은 소수점 1자리까지 반올림

SELECT SUBSTR(TERM_NO, 0, 4) 년도, 
		SUBSTR(TERM_NO, 4, 2) 학기, 
		ROUND(AVG(POINT), 1) 평점
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY ROLLUP( SUBSTR(TERM_NO, 0, 4), SUBSTR(TERM_NO, 4, 2) )
ORDER BY SUBSTR(TERM_NO, 0, 4); 

