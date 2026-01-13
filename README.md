#  rtfCreator

> A macro that allows you to easily create RTF files from your dataset


<img src="https://github.com/stainlessfish/rtfcreator/blob/main/rtfcreateor_megane.png" alt="pharmaforest" width="300" height="300"> 
---

##  Overview

**`rtfCreator`** is a simple SAS macro that enables you to generate RTF tables by specifying:

- Dataset name  
- Number of columns  
- Variable names  
- Column justifications (Left / Right / Center)  
- Column widths  

Optionally, you can apply your own STYLE template or add extra formatting like headers, footers, page breaks, and bottom borders.

---


##  Version history

0.0.1(9July2025) : Initial version
0.0.2(13Jun2026) : bug fix in refdefine. Parameter: LAYOUT Default Value=(Null) to PORTRAIT.

---

##  Parameters

| Parameter    | Required | Description                                      |
|--------------|----------|--------------------------------------------------|
| `DS`         |  Y      | Name of the input dataset                        |
| `COLNUM`     |  Y      | Number of columns                                |
| `VARLST`     |  Y      | List of variable names                           |
| `JUSTLST`    |  Y      | List of justifications (`Left`, `Right`, etc.)   |
| `WIDTHLST`   |  Y      | List of column widths                            |
| `OUTFILE`    |  N      | Output file name                                 |
| `PAGEVAR`    |  N      | Variable flag for page breaks                    |
| `LINEVAR`    |  N      | Variable flag for bottom borders                 |
| `TBLHEAD`    |  N      | Header text to appear at top of the table        |
| `TBLFOOT`    |  N      | Footer text to appear at bottom of the table     |
| `STYLENAM`   |  N      | RTF style template name                          |

---

##  How to Use

### Example A  -- Simply Table;
```sas
%rtfcreator(DS=sashelp.class
,COLNUM  =2
,VARLST  =name sex 
,JUSTLST =Left Center
,WIDTHLST=300 150 
);
```

![image](https://github.com/user-attachments/assets/21a3b247-fd26-47f5-8509-30690e746fa7)

---

### Example B -- use your STYLE template. (e.g. Journal);
```sas
%rtfcreator(DS=sashelp.class
,COLNUM  =2
,VARLST  =name sex 
,JUSTLST =Left Center
,WIDTHLST=300 150 
,STYLENAM=Journal
);
```

![image](https://github.com/user-attachments/assets/05ae8971-0e57-4aed-ac10-0811ad101ce1)

---

### Example C -- Add text outside the table, bottom or top;
```sas
%rtfCreator(DS=sashelp.class
,COLNUM  =2
,VARLST  =name sex 
,JUSTLST =Left Center
,WIDTHLST=300 150 
,TBLHEAD=%str(Table Head)
,TBLFOOT=%str(Table Foot)
);
```

![image](https://github.com/user-attachments/assets/ed41b190-2cbf-4c86-9aba-0436babd314a)

---

### Example D -- Page break (you need to create a page break flag variable in advance, e.g., XXX = 1).;
```sas
data RTFDS1;
  set sashelp.class;
  if _n_ eq 7 then PAGEBRK=1;
run;
%rtfcreator(DS=RTFDS1
,COLNUM  =2
,VARLST  =name sex 
,JUSTLST =Left Center
,WIDTHLST=300 150 
,PAGEVAR=PAGEBRK
);
```

![image](https://github.com/user-attachments/assets/5da9b138-0105-4d3d-b9e7-64feff4227dc)

---

### Example E -- adding a bottom border (you need to create a bottom border flag variable in advance, e.g., XXX = 1).;
```sas
data RTFDS2;
  set sashelp.class;
  if _n_ eq 7 then BLINE=1;
run;
%rtfcreator(DS=RTFDS2
,COLNUM  =2
,VARLST  =name sex 
,JUSTLST =Left Center
,WIDTHLST=300 150 
,LINEVAR=BLINE
);
```
![image](https://github.com/user-attachments/assets/8788d913-60b4-499a-907e-9352d1076666)



## What is SAS Packages?  
PharmaForest is a repository of SAS packages. These packages are built on top of **SAS Packages framework(SPF)**, which was developed by Bartosz Jablonski.  
For more information about SAS Packages framework, see [SAS_PACKAGES](https://github.com/yabwon/SAS_PACKAGES).  
You can also find more SAS Packages(SASPACs) in [SASPAC](https://github.com/SASPAC).

## How to use SAS Packages? (quick start)
### 1. Set-up SPF(SAS Packages Framework)
Firstly, create directory for your packages and assign a fileref to it.
~~~sas      
filename packages "\path\to\your\packages";
~~~
Secondly, enable the SAS Packages Framework.  
(If you don't have SAS Packages Framework installed, follow the instruction in [SPF documentation](https://github.com/yabwon/SAS_PACKAGES/tree/main/SPF/Documentation) to install SAS Packages Framework.)  
~~~sas      
%include packages(SPFinit.sas)
~~~  
### 2. Install SAS package  
Install SAS package you want to use using %installPackage() in SPFinit.sas.
~~~sas      
%installPackage(packagename, sourcePath=\github\path\for\packagename)
~~~
(e.g. %installPackage(ABC, sourcePath=https://github.com/XXXXX/ABC/raw/main/))  
### 3. Load SAS package  
Load SAS package you want to use using %loadPackage() in SPFinit.sas.
~~~sas      
%loadPackage(packagename)
~~~
### Enjoy😁



