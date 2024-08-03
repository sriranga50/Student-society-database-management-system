use project;

 CREATE INDEX idx_team ON Team(team_id, society_id, faction_id);
 CREATE INDEX idx_faction ON Faction(faction_id, society_id);
 CREATE INDEX idx_role ON Role(role_id, society_id);
 CREATE INDEX idx_post ON post(post_id, society_id);
 CREATE INDEX idx_incharge ON Incharge(incharge_id, society_id); 
 CREATE INDEX idx_gensec ON GenSec(gensec_id, society_id);
 CREATE INDEX idx_event ON Event(event_id, gensec_id,faction_id,society_id); 

 CREATE TABLE Expenses(
 	   expense_id INT NOT NULL,
     event_id INT NOT NULL,
     faction_id INT NOT NULL,
     society_id INT NOT NULL,
     gensec_id INT NOT NULL,
     expense_name VARCHAR(100) NOT NULL,
     expense INT NOT NULL,
     is_cleared BOOLEAN DEFAULT FALSE,
     cleared_date DATE NOT NULL,
     PRIMARY KEY(expense_id,event_id,faction_id,society_id)
 	
 );


 CREATE TABLE Approval(
 	approval_id INT NOT NULL PRIMARY KEY,
     event_id INT NOT NULL,
     society_id INT NOT NULL,
     incharge_id INT NOT NULL,
     is_approved BOOLEAN DEFAULT FALSE,
    approved_date DATE NOT NULL,
  FOREIGN KEY (event_id) REFERENCES Event(event_id),
 	FOREIGN KEY (incharge_id,society_id) REFERENCES Incharge(incharge_id,society_id)
 	
 );



 CREATE TABLE Event(
 	   event_id INT NOT NULL,
     faction_id INT NOT NULL,
     society_id INT NOT NULL,
     gensec_id INT NOT NULL,
     is_cancelled BOOLEAN DEFAULT FALSE,
     sevent_date DATE NOT NULL,
     event_time TIME,
     event_budget INT NOT NULL,
     PRIMARY KEY(event_id, gensec_id,faction_id,society_id),
  FOREIGN KEY (society_id) REFERENCES Society(society_id),
 	FOREIGN KEY (faction_id,society_id) REFERENCES Faction(faction_id,society_id),
 	FOREIGN KEY (gensec_id,society_id) REFERENCES GenSec(gensec_id,society_id)
 );

 CREATE TABLE Incharge(
 	   incharge_id INT NOT NULL,
     society_id INT NOT NULL,
     faculty_id INT UNIQUE NOT NULL,
     post_id INT NOT NULL,
     start_date DATE NOT NULL,
     end_date DATE ,
     PRIMARY KEY(society_id, incharge_id),
 	   FOREIGN KEY (faculty_id) REFERENCES Faculty(faculty_id),
 	   FOREIGN KEY (society_id) REFERENCES Society(society_id),
     FOREIGN KEY (post_id,society_id) REFERENCES Post(post_id,society_id)
 );


 CREATE TABLE Member(
 	member_id INT NOT NULL,
     society_id INT NOT NULL,
     roll_num VARCHAR(50) UNIQUE NOT NULL,
     role_id INT NOT NULL,
     faction_id INT NOT NULL,
 	   team_id INT NOT NULL,
     start_date DATE NOT NULL,
     end_date DATE ,
     PRIMARY KEY(society_id, member_id),
 	   FOREIGN KEY (roll_num) REFERENCES Student(roll_num),
 	   FOREIGN KEY (society_id) REFERENCES Society(society_id),
     FOREIGN KEY (faction_id,society_id) REFERENCES Faction(faction_id,society_id),
     FOREIGN KEY (role_id, society_id) REFERENCES Role(role_id, society_id),
 	FOREIGN KEY (team_id, society_id, faction_id) REFERENCES Team(team_id, society_id, faction_id)
     
 );

 CREATE TABLE GenSec(
 	gensec_id INT NOT NULL,
     society_id INT NOT NULL,
     roll_num VARCHAR(50) NOT NULL,
     start_date DATE NOT NULL,
     end_date DATE,
    PRIMARY KEY(society_id, gensec_id),
 	FOREIGN KEY (society_id) REFERENCES Society(society_id),
 	FOREIGN KEY (roll_num) REFERENCES Student(roll_num)
 );

 CREATE TABLE Team(
 	team_id INT NOT NULL,
     society_id INT NOT NULL,
     faction_id INT NOT NULL,
     team_name VARCHAR(100) NOT NULL,
     PRIMARY KEY(society_id, faction_id, team_id),
 	FOREIGN KEY (society_id) REFERENCES Society(society_id),
 	FOREIGN KEY (society_id, faction_id) REFERENCES Faction(society_id, faction_id)
 );

 CREATE TABLE Faction(
 	faction_id INT NOT NULL,
     society_id INT NOT NULL,
     faction_name VARCHAR(100) NOT NULL,
     PRIMARY KEY(society_id,faction_id),
 	FOREIGN KEY (society_id) REFERENCES Society(society_id)
 );


CREATE TABLE Role(
	role_id INT NOT NULL,
    society_id INT NOT NULL,
	role_name VARCHAR(100) NOT NULL,
    PRIMARY KEY(society_id, role_id),
 FOREIGN KEY (society_id) REFERENCES Society(society_id)
);

CREATE TABLE Post(
	post_id INT NOT NULL,
    society_id INT NOT NULL,
	post_name VARCHAR(100) NOT NULL,
    PRIMARY KEY(society_id, post_id),
	FOREIGN KEY (society_id) REFERENCES Society(society_id)
);

CREATE TABLE Faculty(
	faculty_id INT PRIMARY KEY NOT NULL,
    faculty_name VARCHAR(100) NOT NULL,
    faculty_phone VARCHAR(20) NOT NULL,
    faculty_email VARCHAR(100) NOT NULL
);

CREATE TABLE Student(
	roll_num VARCHAR(50) PRIMARY KEY NOT NULL,
    student_name VARCHAR(100) NOT NULL,
    student_phone VARCHAR(20) NOT NULL,
    student_email VARCHAR(100) NOT NULL,
    student_batch YEAR NOT NULL
);

CREATE TABLE Society(
	society_id INT PRIMARY KEY NOT NULL,
    society_name VARCHAR(50) NOT NULL,
    allocated_budget INT NOT NULL,
    remaining_budget INT 
);