
// GLOBAL VARIABLES ///
var popupOpend=0;

/////////////////////////

function countdown( elementName, seconds )
{
	var element, endTime, hours, mins, msLeft, time;

	function twoDigits( n )
	{setAttemptQuestion
		return (n <= 9 ? "0" + n : n);
	}

	function updateTimer()
	{
		msLeft = endTime - (+new Date);
		if ( msLeft < 1000 ) {
			//showProcessingPopup();

			//window.location="save_paper_result.php"
			//window.location="result.html"
			//alert("time out submit your test");
			submitAns();
		} else {
			time = new Date( msLeft );
			hours = time.getUTCHours();
			mins = time.getUTCMinutes();
			sec =time.getUTCSeconds();
			
			element.innerHTML = ''+ (twoDigits( hours ) + ':' + twoDigits( mins ) ) + ':' + twoDigits( time.getUTCSeconds() )+ '';
			//element.innerHTML='';
			setTimeout( updateTimer, time.getUTCMilliseconds() + 500 );
		}
	}

	element = document.getElementById( elementName );
	endTime = (+new Date) + 1000 * seconds + 500;
	updateTimer();
}
function submitTest(alink,index,answerSaveType,questionType){
	var value="";
	var obj="";
	if(questionType==1 || questionType==2){
		value=$("input:radio[name=optionAttribName"+index+"]:checked").val();
	}else if(questionType==3){
		value=$("input:text[name=optionAttribName"+index+"]").val();
	}else if(questionType==5){
		$("input:checkbox[name=optionAttribName"+index+"]:checked").each(function() {
		  value += $(this).val() + ",";
		});
		value = value.slice(0,-1);// Remove last comma 
	}
	if (typeof value === "undefined") {
		value="";
	}
	//0 for not visited, 1 for viewed but not answer, 2 answerd, 3 mark for review,  4 answer and mark for review
	var question_user_status=1;
	if(answerSaveType==3){
		if(value==""){
			question_user_status=3;
		}else{
			question_user_status=4;
		}
	}else if(answerSaveType==4){
		if(value!=""){
			question_user_status=2;
		}
	}
	jQuery.ajax({
		url: 'paper_set_attempt_question.php',
		type: 'post',
		async: true,
		data:"index="+index+"&question_user_status="+question_user_status+"&value="+value+"",
		success: function (data) {
			bootbox.confirm("Are You Sure Want to Complete This Paper?", function(result) {
				if(result==true){
					window.location="save_paper_result.php" ;
				}
			}); 
			$(".modal-footer").attr("style","text-align:right");
			if($(window).width()>600){
				$(".modal").attr("style"," width:250px!important;margin:0 auto;border-radius: 7px; margin:0px auto 0; padding:6px;left:35%;top:10%");
			}else{
				$(".modal").attr("style"," width:250px!important;margin:0 auto;border-radius: 7px; margin:0px auto 0; padding:6px;left:10%;top:10%");
			}
		}
	});
}


function setAttemptQuestion(index, answerSaveType,questionType,amountNext){
	var value="";
	var obj="";
	if(questionType==1 || questionType==2){
		value=$("input:radio[name=optionAttribName"+index+"]:checked").val();
	}else if(questionType==3){
		value=$("input:text[name=optionAttribName"+index+"]").val();
	}else if(questionType==5){
		$("input:checkbox[name=optionAttribName"+index+"]:checked").each(function() {
		  value += $(this).val() + ",";
		});
		value = value.slice(0,-1);// Remove last comma 
	}
	if (typeof value === "undefined") {
		value="";
	}
	//0 for not visited, 1 for viewed but not answer, 2 answerd, 3 mark for review,  4 answer and mark for review
	var question_user_status=1;
	if(answerSaveType==3){
		if(value==""){
			question_user_status=3;
		}else{
			question_user_status=4;
		}
	}else if(answerSaveType==4){
		if(value!=""){
			question_user_status=2;
		}
	}
	showQuestionWithChangeLegend(index,question_user_status,amountNext);
	jQuery.ajax({
		url: 'paper_set_attempt_question.php',
		type: 'post',
		async: true,
		data:"index="+index+"&question_user_status="+question_user_status+"&value="+value+"",
		success: function (data) {
			//TODO 
		}
	});
}
function showQuestionWithChangeLegend(index,user_status,amountNext){
	 
	 if(user_status==0){
		 $("#statusQuestionIndex"+index).removeClass("notVisited");
		 $("#statusQuestionIndex"+index).removeClass("answered");
		 $("#statusQuestionIndex"+index).removeClass("marked");
		 $("#statusQuestionIndex"+index).removeClass("markedAndReviewd");
		 $("#statusQuestionIndex"+index).addClass("notAnswered")
	 }
	 if(user_status==1){
		 $("#statusQuestionIndex"+index).removeClass("notVisited");
		 $("#statusQuestionIndex"+index).removeClass("answered");
		 $("#statusQuestionIndex"+index).removeClass("marked");
		 $("#statusQuestionIndex"+index).removeClass("markedAndReviewd");
		 $("#statusQuestionIndex"+index).addClass("notAnswered")
	 }
	 if(user_status==2 && $("#statusQuestionIndex"+index).attr("class")!="answered"){
		 $("#statusQuestionIndex"+index).removeClass("notVisited");
		 $("#statusQuestionIndex"+index).removeClass("marked");
		 $("#statusQuestionIndex"+index).removeClass("markedAndReviewd");
		 $("#statusQuestionIndex"+index).addClass("answered")
	 }
	 if(user_status==3 && $("#statusQuestionIndex"+index).attr("class")!="marked"){
		 $("#statusQuestionIndex"+index).removeClass("notVisited");
		 $("#statusQuestionIndex"+index).removeClass("answered");
		 $("#statusQuestionIndex"+index).removeClass("markedAndReviewd");
		 $("#statusQuestionIndex"+index).addClass("marked")
	 }
	 if(user_status==4 && $("#statusQuestionIndex"+index).attr("class")!="markedAndReviewd"){
		 $("#statusQuestionIndex"+index).removeClass("notVisited");
		 $("#statusQuestionIndex"+index).removeClass("answered");
		 $("#statusQuestionIndex"+index).removeClass("marked");
		 $("#statusQuestionIndex"+index).addClass("markedAndReviewd")
	 }
	 $(".questionDisplay").hide();
	 $("#question"+(index+amountNext)).show();
 }
 function showQuestion(index){
	 $(".questionDisplay").hide();
	 $("#question"+index).show();
	 if($("#statusQuestionIndex"+index).attr("class")=="notVisited"){
		 $("#statusQuestionIndex"+index).removeClass("notVisited");
		 $("#statusQuestionIndex"+index).addClass("notAnswered")
		 //TODO SEND STATUS TO THE SERVER
	 }
 }
 function clearResponse(index,questionType){
	 	if(questionType==1 || questionType==2){
			$("input:radio[name=optionAttribName"+index+"]").attr('checked', false);
		}else if(questionType==3){
			$("input:text[name=optionAttribName"+index+"]").val("");
		}else if(questionType==5){
			$("input:checkbox[name=optionAttribName"+index+"]").attr('checked', false);
		}
		 $("#statusQuestionIndex"+index).removeClass("notVisited");
		 $("#statusQuestionIndex"+index).removeClass("answered");
		 $("#statusQuestionIndex"+index).removeClass("marked");
		 $("#statusQuestionIndex"+index).removeClass("markedAndReviewd");
		 $("#statusQuestionIndex"+index).addClass("notAnswered")
		 
		//0 for not visited, 1 for viewed but not answer, 2 answerd, 3 mark for review,  4 answer and mark for review
		jQuery.ajax({
			url: 'paper_set_attempt_question.php',
			type: 'post',
			async: true,
			data:"index="+index+"&question_user_status=1&value=",
			success: function (data) {
				//TODO 
			}
		});
 }
 





 function submitAns(){
	var total = 10;
	var score = 0;
	
	// Get User Input
	var q1 = document.forms["quizForm"]["optionAttribName1"].value;
	var q2 = document.forms["quizForm"]["optionAttribName2"].value;
	var q3 = document.forms["quizForm"]["optionAttribName3"].value;
	var q4 = document.forms["quizForm"]["optionAttribName4"].value;
	var q5 = document.forms["quizForm"]["optionAttribName5"].value;
	var q6 = document.forms["quizForm"]["optionAttribName6"].value;
	var q7 = document.forms["quizForm"]["optionAttribName7"].value;
	var q8 = document.forms["quizForm"]["optionAttribName8"].value;
	var q9 = document.forms["quizForm"]["optionAttribName9"].value;
	var q10 = document.forms["quizForm"]["optionAttribName10"].value;
		
	// Set Correct Answers
	var answers = ["3","4","4","1","4","2","1","2","3","3"];
	
	
	
	// Check Answers
	for(i = 1; i <= total;i++){
		if(eval('q'+i) == answers[i - 1]){
			score++;
		}
	}
	
    // Display Results
    
	document.getElementById('results').value = score;
	//alert('You scored '+score+' out of ' +total);
	document.getElementById('container').innerHTML = "";
	document.getElementById('container').style.visibility = 'hidden'; 
	var results = document.getElementById('results');
	results.innerHTML = '<h3>You scored <span>'+score+'</span> out of <span>'+total+'</span></h3>';
	document.getElementById('report').style.visibility = 'visible';
	document.getElementById('result').style.visibility = 'visible';
	return false;
}