/**
 * 
 */
package application;

import com.sun.org.apache.xpath.internal.operations.Bool;
import jpaentities.*;
import utils.Constants;

import java.math.BigInteger;
import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

/**
 * @author Haseeb Shahid
 *
 */
@SuppressWarnings("serial")
public class Instructor extends TCSUser {


/**
	 * Default constructor
	 */
	public Instructor() {
		this.setUserType(Constants.UserType.INSTRUCTOR);
	}

	/**
	 * @param netId
	 * @param email
	 * @param password
	 * @param firstName
	 * @param lastName
	 */
	public Instructor(String netId, String email, String password, String firstName, String lastName) {
		super(netId, email, password, firstName, lastName, "INSTRUCTOR");
	}
	
	/**
	 * @param user
	 */
	public Instructor(TCSUser user) {
		this.setNetId(user.getNetId());
		this.setEmail(user.getEmail());
		this.setPassword(user.getPassword());
		this.setFirstName(user.getFirstName());
		this.setLastName(user.getLastName());
		this.setUserType(Constants.UserType.INSTRUCTOR);
	}



	public boolean makeCourseRequest(String testName,String courseidentifier,String section,String startTimeString,String endTimeString, String startDateString, String endDateString, String term, String course,String instructorId, String duration) throws ParseException {
		Retriever retriever = Retriever.getInstance();

		char[] chars = "abcdefghijklmnopqrstuvwxyz".toCharArray();
		StringBuilder sb = new StringBuilder();
		Random random = new Random();
		for (int i = 0; i < 3; i++) {
			char c = chars[random.nextInt(chars.length)];
			sb.append(c);
		}
		String output = sb.toString();
		System.out.println(output);

		startDateString = startDateString + " " + startTimeString;
		endDateString = endDateString + " " + endTimeString;


		SimpleDateFormat dateFormatter = new SimpleDateFormat("m/d/y HH:mm");

		int durationInt = Integer.parseInt(duration);
		int termInt = Integer.parseInt(term);

		Date startDate = dateFormatter.parse(startDateString);
		Date endDate = dateFormatter.parse(endDateString);


		String refinedId = course + courseidentifier +"-"+ section + "_" + term+ "_" + output;
		String TCSClassId = course + courseidentifier +"-"+ section + "_" +term;

		int numberOfStudents = 30;
		Validator validator = Validator.getInstance();
		Boolean possible = validator.isSchedulable(startDate,endDate,numberOfStudents,durationInt);

		if(possible){

			Exam exam = new Exam(durationInt,endDate,testName,"PENDING","COURSE",instructorId,30,30,refinedId,startDate,termInt,1);
			retriever.persist(exam);

			CourseExamPK courseExamPK = new CourseExamPK();
			courseExamPK.setExamRefinedId(refinedId);
			courseExamPK.setTCSClassRefinedId(TCSClassId);

			CourseExam courseExam = new CourseExam();
			courseExam.setId(courseExamPK);

			retriever.persist(courseExam);
			return true;

		}else{
			return false;
		}





	}

	public boolean makeAdhocRequest(String testName,String courseidentifier,String section,String startTimeString,String endTimeString, String startDateString, String endDateString, String term, String course,String instructorId, String duration, int numberOfStudents,String[] netId, String[]firstName,String[]lastName) throws ParseException {

		Retriever retriever = Retriever.getInstance();

		char[] chars = "abcdefghijklmnopqrstuvwxyz".toCharArray();
		StringBuilder sb = new StringBuilder();
		Random random = new Random();
		for (int i = 0; i < 5; i++) {
			char c = chars[random.nextInt(chars.length)];
			sb.append(c);
		}
		String output = sb.toString();
		System.out.println(output);
		startDateString = startDateString + " " + startTimeString;
		endDateString = endDateString + " " + endTimeString;
		SimpleDateFormat dateFormatter = new SimpleDateFormat("m/d/y HH:mm");
		Date startDate = dateFormatter.parse(startDateString);
		Date endDate = dateFormatter.parse(endDateString);
		int durationInt = Integer.parseInt(duration);
		int termInt = Integer.parseInt(term);

		Validator validator = Validator.getInstance();
		Boolean possible = validator.isSchedulable(startDate,endDate,numberOfStudents,durationInt);



		if(possible){
			String refinedId = "ad" + "_" + term+ "_" + output;
			String TCSClassId = course + courseidentifier +"-"+ section + "_" +term;

			Exam exam = new Exam(durationInt,endDate,testName,"PENDING","AD-HOC",instructorId,30,numberOfStudents,refinedId,startDate,termInt,1);
			retriever.persist(exam);

			for(int i = 0; i < numberOfStudents;i++){
				AdHocExam adHocExam = new AdHocExam();
				AdHocExamPK adHocExamPK = new AdHocExamPK();
				adHocExam.setStudentFirstName(firstName[i]);
				adHocExam.setStudentLastName(lastName[i]);
				adHocExamPK.setExamRefinedId(refinedId);
				adHocExamPK.setStudentNetId(netId[i]);
				adHocExam.setId(adHocExamPK);
				retriever.persist(adHocExam);
			}
			return true;
		}else{
			return false;
		}




	}

	public void cancelExam(String examRefinedID){
		Retriever retriever = Retriever.getInstance();
		Exam exam = retriever.getExam(examRefinedID);
		System.out.println("Before: " + exam);
		exam.cancel();
		System.out.println("After: " + exam);

		retriever.persist(exam);
	}

}
