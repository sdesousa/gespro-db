#------------------------------------------------------------
#        Script MySQL.
#------------------------------------------------------------


#------------------------------------------------------------
# Table: GP_EMPLOYEE
#------------------------------------------------------------

CREATE TABLE GP_EMPLOYEE(
        EMP_ID        Int  Auto_increment  NOT NULL ,
        FILE_NUMBER   Varchar (5) NOT NULL ,
        LASTNAME      Varchar (128) NOT NULL ,
        FIRSTNAME     Varchar (128) NOT NULL ,
        PHONE_NUMBER  Varchar (32) NOT NULL ,
        PASSWORD      Varchar (32) NOT NULL ,
        CREATION_DATE Datetime NOT NULL ,
        UPDATE_DATE   Datetime ,
        EMAIL         Varchar (128) NOT NULL ,
        LOGIN         Varchar (32) NOT NULL
	,CONSTRAINT GP_EMPLOYEE_AK UNIQUE (EMAIL,LOGIN)
	,CONSTRAINT GP_EMPLOYEE_PK PRIMARY KEY (EMP_ID)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: GP_SECRETARY
#------------------------------------------------------------

CREATE TABLE GP_SECRETARY(
        EMP_ID        Int NOT NULL
	,CONSTRAINT GP_SECRETARY_PK PRIMARY KEY (EMP_ID)
	,CONSTRAINT GP_SECRETARY_GP_EMPLOYEE_FK FOREIGN KEY (EMP_ID) REFERENCES GP_EMPLOYEE(EMP_ID) ON DELETE CASCADE
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: GP_ACCOUNTANT
#------------------------------------------------------------

CREATE TABLE GP_ACCOUNTANT(
        EMP_ID        Int NOT NULL 
	,CONSTRAINT GP_COMPTABLE_PK PRIMARY KEY (EMP_ID)
	,CONSTRAINT GP_COMPTABLE_GP_EMPLOYEE_FK FOREIGN KEY (EMP_ID) REFERENCES GP_EMPLOYEE(EMP_ID) ON DELETE CASCADE
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: GP_PROJECT_MANAGER
#------------------------------------------------------------

CREATE TABLE GP_PROJECT_MANAGER(
        EMP_ID        Int NOT NULL 
	,CONSTRAINT GP_PROJECT_MANAGER_PK PRIMARY KEY (EMP_ID)
	,CONSTRAINT GP_PROJECT_MANAGER_GP_EMPLOYEE_FK FOREIGN KEY (EMP_ID) REFERENCES GP_EMPLOYEE(EMP_ID) ON DELETE CASCADE
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: GP_ADMIN
#------------------------------------------------------------

CREATE TABLE GP_ADMIN(
        EMP_ID        Int NOT NULL 
	,CONSTRAINT GP_ADMIN_PK PRIMARY KEY (EMP_ID)
	,CONSTRAINT GP_ADMIN_GP_EMPLOYEE_FK FOREIGN KEY (EMP_ID) REFERENCES GP_EMPLOYEE(EMP_ID) ON DELETE CASCADE
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: GP_DIRECTOR
#------------------------------------------------------------

CREATE TABLE GP_DIRECTOR(
        EMP_ID        Int NOT NULL 
	,CONSTRAINT GP_DIRECTOR_PK PRIMARY KEY (EMP_ID)
	,CONSTRAINT GP_DIRECTOR_GP_EMPLOYEE_FK FOREIGN KEY (EMP_ID) REFERENCES GP_EMPLOYEE(EMP_ID) ON DELETE CASCADE
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: GP_ORGANIZATION
#------------------------------------------------------------

CREATE TABLE GP_ORGANIZATION(
        ORG_ID        Int  Auto_increment  NOT NULL ,
        ORG_CODE      Varchar (32) NOT NULL ,
        NAME          Varchar (32) NOT NULL ,
        PHONE_NUMBER  Varchar (32) NOT NULL ,
        CONTACT_NAME  Varchar (128) NOT NULL ,
        CONTACT_EMAIL Varchar (128) NOT NULL ,
        ADR_WEB       Varchar (128) NOT NULL
	,CONSTRAINT GP_ORGANIZATION_PK PRIMARY KEY (ORG_ID)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: GP_PROJECT
#------------------------------------------------------------

CREATE TABLE GP_PROJECT(
        PROJECT_ID    Int  Auto_increment  NOT NULL ,
        PROJECT_CODE  Varchar (32) NOT NULL ,
        NAME          Varchar (32) NOT NULL ,
        DESCRIPTION   Varchar (255) NOT NULL ,
        START_DATE    Date NOT NULL ,
        END_DATE      Date NOT NULL ,
        AMOUNT        Real NOT NULL ,
        CREATION_DATE Datetime NOT NULL ,
        UPDATE_DATE   Datetime ,
        ORG_ID        Int NOT NULL ,
        EMP_ID        Int NOT NULL
	,CONSTRAINT GP_PROJECT_PK PRIMARY KEY (PROJECT_ID)

	,CONSTRAINT GP_PROJECT_GP_ORGANIZATION_FK FOREIGN KEY (ORG_ID) REFERENCES GP_ORGANIZATION(ORG_ID)
	,CONSTRAINT GP_PROJECT_GP_PROJECT_MANAGER0_FK FOREIGN KEY (EMP_ID) REFERENCES GP_PROJECT_MANAGER(EMP_ID)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: GP_PHASE
#------------------------------------------------------------

CREATE TABLE GP_PHASE(
        PHASE_ID      Int  Auto_increment  NOT NULL ,
        PHASE_CODE    Varchar (32) NOT NULL ,
        DESCRIPTION   Varchar (255) NOT NULL ,
        START_DATE    Date NOT NULL ,
        END_DATE      Date NOT NULL ,
        AMOUNT        Real NOT NULL COMMENT "Cout de la phase"  ,
        STATUS        Bool NOT NULL ,
        IS_ENDED      Bool NOT NULL COMMENT "Precise si la phase est terminee"  ,
        CREATION_DATE Datetime NOT NULL ,
        UPDATE_DATE   Datetime ,
        PROJECT_ID    Int NOT NULL
	,CONSTRAINT GP_PHASE_PK PRIMARY KEY (PHASE_ID)

	,CONSTRAINT GP_PHASE_GP_PROJECT_FK FOREIGN KEY (PROJECT_ID) REFERENCES GP_PROJECT(PROJECT_ID)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: GP_BILL
#------------------------------------------------------------

CREATE TABLE GP_BILL(
        BILL_ID     Int  Auto_increment  NOT NULL ,
        BILL_CODE   Varchar (32) NOT NULL ,
        AMOUNT      Real NOT NULL ,
        BILL_STATUS Enum ("EDITED","TRANSMITTED","PAID","BLOCKED") NOT NULL ,
        PHASE_ID    Int NOT NULL
	,CONSTRAINT GP_BILL_PK PRIMARY KEY (BILL_ID)

	,CONSTRAINT GP_BILL_GP_PHASE_FK FOREIGN KEY (PHASE_ID) REFERENCES GP_PHASE(PHASE_ID)
	,CONSTRAINT GP_BILL_GP_PHASE_AK UNIQUE (PHASE_ID)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: GP_DELIVERABLE
#------------------------------------------------------------

CREATE TABLE GP_DELIVERABLE(
        DEL_ID        Int  Auto_increment  NOT NULL ,
        DEL_CODE      Varchar (32) NOT NULL ,
        LABEL         Varchar (32) NOT NULL ,
        DESCRIPTION   Varchar (255) NOT NULL ,
        DEL_PATH      Varchar (32) NOT NULL ,
        CREATION_DATE Datetime NOT NULL ,
        PHASE_ID      Int NOT NULL
	,CONSTRAINT GP_DELIVERABLE_PK PRIMARY KEY (DEL_ID)

	,CONSTRAINT GP_DELIVERABLE_GP_PHASE_FK FOREIGN KEY (PHASE_ID) REFERENCES GP_PHASE(PHASE_ID)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: GP_EMP_REA_PHASE
#------------------------------------------------------------

CREATE TABLE GP_EMP_REA_PHASE(
        ASSO_REA_ID   Int  Auto_increment  NOT NULL ,
        CREATION_DATE Datetime NOT NULL ,
        PHASE_ID      Int NOT NULL ,
        EMP_ID        Int NOT NULL
	,CONSTRAINT GP_EMP_REA_PHASE_PK PRIMARY KEY (ASSO_REA_ID)

	,CONSTRAINT GP_EMP_REA_PHASE_GP_PHASE_FK FOREIGN KEY (PHASE_ID) REFERENCES GP_PHASE(PHASE_ID)
	,CONSTRAINT GP_EMP_REA_PHASE_GP_EMPLOYEE0_FK FOREIGN KEY (EMP_ID) REFERENCES GP_EMPLOYEE(EMP_ID)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: GP_ADDRESS
#------------------------------------------------------------

CREATE TABLE GP_ADDRESS(
        ADDRESS_ID    Int  Auto_increment  NOT NULL ,
        STREET_NUMBER Int NOT NULL ,
        STREET_LABEL  Varchar (250) NOT NULL ,
        ZIP_CODE      Int NOT NULL ,
        COUNTRY       Varchar (50) NOT NULL ,
        IS_MAIN       Bool NOT NULL COMMENT "Si Adresse principale"  ,
        ORG_ID        Int NOT NULL ,
        EMP_ID        Int
	,CONSTRAINT GP_ADDRESS_PK PRIMARY KEY (ADDRESS_ID)

	,CONSTRAINT GP_ADDRESS_GP_ORGANIZATION_FK FOREIGN KEY (ORG_ID) REFERENCES GP_ORGANIZATION(ORG_ID)
	,CONSTRAINT GP_ADDRESS_GP_EMPLOYEE0_FK FOREIGN KEY (EMP_ID) REFERENCES GP_EMPLOYEE(EMP_ID)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: GP_TECHNICIAN
#------------------------------------------------------------

CREATE TABLE GP_TECHNICIAN(
        EMP_ID          Int NOT NULL ,
        LAST_DIPLOMA    Varchar (100) ,
        GRADUATION_YEAR Int NOT NULL COMMENT "Annee d'obtention du dernier diplome"
	,CONSTRAINT GP_TECHNICIAN_PK PRIMARY KEY (EMP_ID)
	,CONSTRAINT GP_TECHNICIAN_GP_EMPLOYEE_FK FOREIGN KEY (EMP_ID) REFERENCES GP_EMPLOYEE(EMP_ID) ON DELETE CASCADE
)ENGINE=InnoDB;

