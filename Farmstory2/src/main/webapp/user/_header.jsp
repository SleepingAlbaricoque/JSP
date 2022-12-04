<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>게시판</title>
   	<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css"/>
    <link rel="stylesheet" href="/Farmstory2/css/style.css"/>
    <link rel="stylesheet" href="/Farmstory2/css/user.css"/>
    <link rel="stylesheet" href="/Farmstory2/css/board.css"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
    <script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>    
    <style>
        #board > .list > form {
            float: right;
            margin-bottom: -14px;
        }

        #board > .list > form > input[name=search]{
            width: 200px;
            height: 26px;
            text-indent: 6px;
            border: 1px solid #d7d7d7;
        }
        #board > .list > form > input[type=submit]{
            border: 1px solid #d7d7d7;
            background: #f2f2f2; 
            color: #111;
            padding: 6px;
        }
    </style>
</head>
<body>
    <div id="wrapper">
        <header>
            <a href="/Farmstory2/index.jsp" class="logo"><img src="/Farmstory2/img/logo.png" alt="로고"/></a>
            <p>
                <a href="/Farmstory2/">HOME |</a>
                <span>${sessionScope.sessUser.nick}</span>님 반갑습니다 
                <a href="/Farmstory2/user/info.do"> 회원정보</a>
                <a href="/Farmstory2/user/logout.do?uid=${sessUser.uid}">[로그아웃] |</a>
                <a href="#">고객센터</a>
            </p>
            <img src="/Farmstory2/img/head_txt_img.png" alt="3만원 이상 무료배송"/>
            
            <ul class="gnb">
                <li><a href="/Farmstory2/introduction/hello.do">팜스토리소개</a></li>
                <li><a href="/Farmstory2/board/list.do?group=market&cate=market"><img src="/Farmstory2/img/head_menu_badge.png" alt="30%"/>장바구니</a></li>
                <li><a href="/Farmstory2/board/list.do?group=croptalk&cate=story">농작물이야기</a></li>
                <li><a href="/Farmstory2/board/list.do?group=event&cate=event">이벤트</a></li>
                <li><a href="/Farmstory2/board/list.do?group=community&cate=notice">커뮤니티</a></li>
            </ul>
        </header>