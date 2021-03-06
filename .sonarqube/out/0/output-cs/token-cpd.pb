?
cC:\Users\boris\source\repos\AmpleChat\API\AmpleChat API\AmpleChat API\Controllers\UserController.cs
	namespace 	
AmpleChat_API
 
. 
Controllers #
{ 
[ 
Route 

(
 
$str 
) 
] 
[		 
ApiController		 
]		 
public

 

class

 
UserController

 
:

  !
ControllerBase

" 0
{ 
private 
readonly 
UserService $
userService% 0
;0 1
public 
UserController 
( 
UserService )
uss* -
)- .
{ 	
userService 
= 
uss 
; 
} 	
[ 	
HttpPost	 
( 
$str 
) 
] 
public 
async 
Task 
< 
IActionResult '
>' (

CreateUser) 3
(3 4
[4 5
FromBody5 =
]= >
RegisterModel? L
modelM R
)R S
{ 	
if 
( 
! 

ModelState 
. 
IsValid #
||$ &
!' (
model( -
.- .
IsValid. 5
(5 6
)6 7
)7 8
return 

BadRequest !
(! "
$str" 6
)6 7
;7 8
if 
( 
userService 
. 

UserExists &
(& '
model' ,
., -
Email- 2
,2 3
model4 9
.9 :
UserName: B
)B C
)C D
return 

BadRequest !
(! "
$str" N
)N O
;O P
var 
userCreated 
= 
await #
userService$ /
./ 0
CreateAccount0 =
(= >
model> C
)C D
;D E
if 
( 
userCreated 
) 
return 
Ok 
( 
$str (
)( )
;) *
return!! 

BadRequest!! 
(!! 
$str!! 5
)!!5 6
;!!6 7
}"" 	
}$$ 
}%% ?
aC:\Users\boris\source\repos\AmpleChat\API\AmpleChat API\AmpleChat API\Database\DatabaseService.cs
	namespace 	
AmpleChat_API
 
. 
Database  
{ 
public 

class 
DatabaseService  
:! "
	DbContext# ,
{ 
public 
DbSet 
< 
User 
> 
Users  
{! "
get# &
;& '
set( +
;+ ,
}- .
public

 
DbSet

 
<

 
ContactRequest

 #
>

# $
ContactRequests

% 4
{

5 6
get

7 :
;

: ;
set

< ?
;

? @
}

A B
public 
DbSet 
< 
ChatMessage  
>  !
ChatMessages" .
{/ 0
get1 4
;4 5
set6 9
;9 :
}; <
public 
DatabaseService 
( 
DbContextOptions /
</ 0
DatabaseService0 ?
>? @
optionsA H
)H I
: 	
base
 
( 
options 
) 
{ 	
} 	
	protected 
override 
void 
OnModelCreating  /
(/ 0
ModelBuilder0 <
builder= D
)D E
{ 	
base 
. 
OnModelCreating  
(  !
builder! (
)( )
;) *
builder 
. 
Entity 
< 
User 
>  
(  !
)! "
. 
HasMany 
( 
i 
=> 
i 
.  
Contacts  (
)( )
. 
WithOne 
( 
) 
. 
OnDelete 
( 
DeleteBehavior (
.( )
NoAction) 1
)1 2
;2 3
builder   
.   
Entity   
<   
User   
>    
(    !
)  ! "
.!! 
HasMany!! 
(!! 
i!! 
=>!! 
i!! 
.!!  
ContactRequests!!  /
)!!/ 0
."" 
WithOne"" 
("" 
i"" 
=>"" 
i"" 
.""  
User""  $
)""$ %
.## 
HasForeignKey## 
(## 
i##  
=>##! #
i##$ %
.##% &
UserId##& ,
)##, -
.$$ 
OnDelete$$ 
($$ 
DeleteBehavior$$ (
.$$( )
NoAction$$) 1
)$$1 2
;$$2 3
builder(( 
.(( 
Entity(( 
<(( 
User(( 
>((  
(((  !
)((! "
.)) 
HasMany)) 
()) 
i)) 
=>)) 
i)) 
.))  
Messages))  (
)))( )
.** 
WithOne** 
(** 
i** 
=>** 
i** 
.**  
User**  $
)**$ %
.++ 
HasForeignKey++ 
(++ 
i++  
=>++! #
i++$ %
.++% &
UserId++& ,
)++, -
.,, 
OnDelete,, 
(,, 
DeleteBehavior,, (
.,,( )
NoAction,,) 1
),,1 2
;,,2 3
}-- 	
}.. 
}// ?
dC:\Users\boris\source\repos\AmpleChat\API\AmpleChat API\AmpleChat API\Database\Models\ChatMessage.cs
	namespace 	
AmpleChat_API
 
. 
Database  
.  !
Models! '
{ 
public 
class 
ChatMessage 
{ 
public 
int	 
Id 
{ 
get 
; 
set 
; 
} 
public 
string	 
Message 
{ 
get 
; 
set "
;" #
}$ %
public 
int	 
UserId 
{ 
get 
; 
set 
; 
}  !
public 
User	 
User 
{ 
get 
; 
set 
; 
}  
}		 
} ?
gC:\Users\boris\source\repos\AmpleChat\API\AmpleChat API\AmpleChat API\Database\Models\ContactRequest.cs
	namespace 	
AmpleChat_API
 
. 
Database  
.  !
Models! '
{ 
public 

class 
ContactRequest 
{ 
public 
int 
Id 
{ 
get 
; 
set  
;  !
}" #
public 
bool 
Accepted 
{ 
get "
;" #
set$ '
;' (
}) *
public 
int 
UserId 
{ 
get 
;  
set! $
;$ %
}& '
public		 
User		 
User		 
{		 
get		 
;		 
set		  #
;		# $
}		% &
}

 
} ?
]C:\Users\boris\source\repos\AmpleChat\API\AmpleChat API\AmpleChat API\Database\Models\User.cs
	namespace 	
AmpleChat_API
 
. 
Database  
.  !
Models! '
{ 
public 

class 
User 
{ 
public 
int 
Id 
{ 
get 
; 
set  
;  !
}" #
public		 
string		 
UserName		 
{		  
get		! $
;		$ %
set		& )
;		) *
}		+ ,
public

 
string

 
Email

 
{

 
get

 !
;

! "
set

# &
;

& '
}

( )
public 
string 
Password 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 
IList 
< 
User 
> 
Contacts #
{$ %
get& )
;) *
set+ .
;. /
}0 1
=2 3
new4 7
List8 <
<< =
User= A
>A B
(B C
)C D
;D E
public 
IList 
< 
ContactRequest #
># $
ContactRequests% 4
{5 6
get7 :
;: ;
set< ?
;? @
}A B
=C D
newE H
ListI M
<M N
ContactRequestN \
>\ ]
(] ^
)^ _
;_ `
public 
IList 
< 
ChatMessage  
>  !
Messages" *
{+ ,
get- 0
;0 1
set2 5
;5 6
}7 8
=9 :
new; >
List? C
<C D
ChatMessageD O
>O P
(P Q
)Q R
;R S
} 
} ?H
jC:\Users\boris\source\repos\AmpleChat\API\AmpleChat API\AmpleChat API\Migrations\20211011221449_Initial.cs
	namespace 	
AmpleChat_API
 
. 

Migrations "
{ 
public 

partial 
class 
Initial  
:! "
	Migration# ,
{ 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{ 	
migrationBuilder		 
.		 
CreateTable		 (
(		( )
name

 
:

 
$str

 
,

 
columns 
: 
table 
=> !
new" %
{ 
Id 
= 
table 
. 
Column %
<% &
int& )
>) *
(* +
type+ /
:/ 0
$str1 6
,6 7
nullable8 @
:@ A
falseB G
)G H
. 

Annotation #
(# $
$str$ 8
,8 9
$str: @
)@ A
,A B
UserName 
= 
table $
.$ %
Column% +
<+ ,
string, 2
>2 3
(3 4
type4 8
:8 9
$str: I
,I J
nullableK S
:S T
trueU Y
)Y Z
,Z [
Email 
= 
table !
.! "
Column" (
<( )
string) /
>/ 0
(0 1
type1 5
:5 6
$str7 F
,F G
nullableH P
:P Q
trueR V
)V W
,W X
Password 
= 
table $
.$ %
Column% +
<+ ,
string, 2
>2 3
(3 4
type4 8
:8 9
$str: I
,I J
nullableK S
:S T
trueU Y
)Y Z
,Z [
UserId 
= 
table "
." #
Column# )
<) *
int* -
>- .
(. /
type/ 3
:3 4
$str5 :
,: ;
nullable< D
:D E
trueF J
)J K
} 
, 
constraints 
: 
table "
=># %
{ 
table 
. 

PrimaryKey $
($ %
$str% /
,/ 0
x1 2
=>3 5
x6 7
.7 8
Id8 :
): ;
;; <
table 
. 

ForeignKey $
($ %
name 
: 
$str 5
,5 6
column 
: 
x  !
=>" $
x% &
.& '
UserId' -
,- .
principalTable &
:& '
$str( /
,/ 0
principalColumn '
:' (
$str) -
)- .
;. /
} 
) 
; 
migrationBuilder 
. 
CreateTable (
(( )
name 
: 
$str $
,$ %
columns   
:   
table   
=>   !
new  " %
{!! 
Id"" 
="" 
table"" 
."" 
Column"" %
<""% &
int""& )
>"") *
(""* +
type""+ /
:""/ 0
$str""1 6
,""6 7
nullable""8 @
:""@ A
false""B G
)""G H
.## 

Annotation## #
(### $
$str##$ 8
,##8 9
$str##: @
)##@ A
,##A B
Message$$ 
=$$ 
table$$ #
.$$# $
Column$$$ *
<$$* +
string$$+ 1
>$$1 2
($$2 3
type$$3 7
:$$7 8
$str$$9 H
,$$H I
nullable$$J R
:$$R S
true$$T X
)$$X Y
,$$Y Z
UserId%% 
=%% 
table%% "
.%%" #
Column%%# )
<%%) *
int%%* -
>%%- .
(%%. /
type%%/ 3
:%%3 4
$str%%5 :
,%%: ;
nullable%%< D
:%%D E
false%%F K
)%%K L
}&& 
,&& 
constraints'' 
:'' 
table'' "
=>''# %
{(( 
table)) 
.)) 

PrimaryKey)) $
())$ %
$str))% 6
,))6 7
x))8 9
=>)): <
x))= >
.))> ?
Id))? A
)))A B
;))B C
table** 
.** 

ForeignKey** $
(**$ %
name++ 
:++ 
$str++ <
,++< =
column,, 
:,, 
x,,  !
=>,," $
x,,% &
.,,& '
UserId,,' -
,,,- .
principalTable-- &
:--& '
$str--( /
,--/ 0
principalColumn.. '
:..' (
$str..) -
,..- .
onDelete//  
://  !
ReferentialAction//" 3
.//3 4
Cascade//4 ;
)//; <
;//< =
}00 
)00 
;00 
migrationBuilder22 
.22 
CreateTable22 (
(22( )
name33 
:33 
$str33 '
,33' (
columns44 
:44 
table44 
=>44 !
new44" %
{55 
Id66 
=66 
table66 
.66 
Column66 %
<66% &
int66& )
>66) *
(66* +
type66+ /
:66/ 0
$str661 6
,666 7
nullable668 @
:66@ A
false66B G
)66G H
.77 

Annotation77 #
(77# $
$str77$ 8
,778 9
$str77: @
)77@ A
,77A B
Accepted88 
=88 
table88 $
.88$ %
Column88% +
<88+ ,
bool88, 0
>880 1
(881 2
type882 6
:886 7
$str888 =
,88= >
nullable88? G
:88G H
false88I N
)88N O
,88O P
UserId99 
=99 
table99 "
.99" #
Column99# )
<99) *
int99* -
>99- .
(99. /
type99/ 3
:993 4
$str995 :
,99: ;
nullable99< D
:99D E
false99F K
)99K L
}:: 
,:: 
constraints;; 
:;; 
table;; "
=>;;# %
{<< 
table== 
.== 

PrimaryKey== $
(==$ %
$str==% 9
,==9 :
x==; <
=>=== ?
x==@ A
.==A B
Id==B D
)==D E
;==E F
table>> 
.>> 

ForeignKey>> $
(>>$ %
name?? 
:?? 
$str?? ?
,??? @
column@@ 
:@@ 
x@@  !
=>@@" $
x@@% &
.@@& '
UserId@@' -
,@@- .
principalTableAA &
:AA& '
$strAA( /
,AA/ 0
principalColumnBB '
:BB' (
$strBB) -
,BB- .
onDeleteCC  
:CC  !
ReferentialActionCC" 3
.CC3 4
CascadeCC4 ;
)CC; <
;CC< =
}DD 
)DD 
;DD 
migrationBuilderFF 
.FF 
CreateIndexFF (
(FF( )
nameGG 
:GG 
$strGG .
,GG. /
tableHH 
:HH 
$strHH %
,HH% &
columnII 
:II 
$strII  
)II  !
;II! "
migrationBuilderKK 
.KK 
CreateIndexKK (
(KK( )
nameLL 
:LL 
$strLL 1
,LL1 2
tableMM 
:MM 
$strMM (
,MM( )
columnNN 
:NN 
$strNN  
)NN  !
;NN! "
migrationBuilderPP 
.PP 
CreateIndexPP (
(PP( )
nameQQ 
:QQ 
$strQQ '
,QQ' (
tableRR 
:RR 
$strRR 
,RR 
columnSS 
:SS 
$strSS  
)SS  !
;SS! "
}TT 	
	protectedVV 
overrideVV 
voidVV 
DownVV  $
(VV$ %
MigrationBuilderVV% 5
migrationBuilderVV6 F
)VVF G
{WW 	
migrationBuilderXX 
.XX 
	DropTableXX &
(XX& '
nameYY 
:YY 
$strYY $
)YY$ %
;YY% &
migrationBuilder[[ 
.[[ 
	DropTable[[ &
([[& '
name\\ 
:\\ 
$str\\ '
)\\' (
;\\( )
migrationBuilder^^ 
.^^ 
	DropTable^^ &
(^^& '
name__ 
:__ 
$str__ 
)__ 
;__ 
}`` 	
}aa 
}bb ?

PC:\Users\boris\source\repos\AmpleChat\API\AmpleChat API\AmpleChat API\Program.cs
	namespace

 	
AmpleChat_API


 
{ 
public 

class 
Program 
{ 
public 
static 
void 
Main 
(  
string  &
[& '
]' (
args) -
)- .
{ 	
CreateHostBuilder 
( 
args "
)" #
.# $
Build$ )
() *
)* +
.+ ,
Run, /
(/ 0
)0 1
;1 2
} 	
public 
static 
IHostBuilder "
CreateHostBuilder# 4
(4 5
string5 ;
[; <
]< =
args> B
)B C
=>D F
Host 
.  
CreateDefaultBuilder %
(% &
args& *
)* +
. $
ConfigureWebHostDefaults )
() *

webBuilder* 4
=>5 7
{ 

webBuilder 
. 

UseStartup )
<) *
Startup* 1
>1 2
(2 3
)3 4
;4 5
} 
) 
; 
} 
} ?
cC:\Users\boris\source\repos\AmpleChat\API\AmpleChat API\AmpleChat API\Services\Models\LoginModel.cs
	namespace 	
AmpleChat_API
 
. 
Services  
.  !
Models! '
{ 
public 

class 

LoginModel 
{ 
[ 	
Required	 
] 
public 
string 
UserNameOrEmail %
{& '
get( +
;+ ,
set- 0
;0 1
}2 3
[

 	
Required

	 
]

 
public 
string 
Password 
{  
get! $
;$ %
set& )
;) *
}+ ,
} 
} ?
fC:\Users\boris\source\repos\AmpleChat\API\AmpleChat API\AmpleChat API\Services\Models\RegisterModel.cs
	namespace 	
AmpleChat_API
 
. 
Services  
.  !
Models! '
{ 
public 

class 
RegisterModel 
{ 
[ 	
Required	 
] 
[ 	
StringLength	 
( 
$num 
, 
MinimumLength '
=( )
$num* +
)+ ,
], -
public		 
string		 
UserName		 
{		  
get		! $
;		$ %
set		& )
;		) *
}		+ ,
[ 	
Required	 
] 
[ 	
StringLength	 
( 
$num 
, 
MinimumLength (
=) *
$num+ ,
), -
]- .
public 
string 
Email 
{ 
get !
;! "
set# &
;& '
}( )
[ 	
Required	 
] 
[ 	
StringLength	 
( 
$num 
, 
MinimumLength '
=( )
$num* +
)+ ,
], -
public 
string 
Password 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 
bool 
IsValid 
( 
) 
{ 	
var 
email 
= 
! 
string 
.  
IsNullOrEmpty  -
(- .
Email. 3
)3 4
;4 5
var 
username 
= 
! 
string "
." #
IsNullOrEmpty# 0
(0 1
UserName1 9
)9 :
;: ;
var 
password 
= 
! 
string "
." #
IsNullOrEmpty# 0
(0 1
Password1 9
)9 :
;: ;
return 
email 
&& 
username $
&&% '
password( 0
;0 1
} 	
} 
} ?
]C:\Users\boris\source\repos\AmpleChat\API\AmpleChat API\AmpleChat API\Services\UserService.cs
	namespace 	
AmpleChat_API
 
. 
Services  
{		 
public

 

class

 
UserService

 
{ 
private 
readonly 
DatabaseService (
databaseService) 8
;8 9
public 
UserService 
( 
DatabaseService *
dbs+ .
). /
{ 	
databaseService 
= 
dbs !
;! "
} 	
public 
async 
Task 
< 
bool 
> 
CreateAccount  -
(- .
RegisterModel. ;
model< A
)A B
{ 	
var 
passwordHash 
= 
HashPassword +
(+ ,
model, 1
.1 2
Password2 :
): ;
;; <
await 
databaseService !
.! "
Users" '
.' (
AddAsync( 0
(0 1
new1 4
User5 9
{ 
UserName 
= 
model  
.  !
UserName! )
,) *
Email 
= 
model 
. 
Email #
,# $
Password 
= 
passwordHash '
,' (
} 
) 
; 
await 
databaseService !
.! "
SaveChangesAsync" 2
(2 3
)3 4
;4 5
return!! 
true!! 
;!! 
}"" 	
public$$ 
bool$$ 

UserExists$$ 
($$ 
string$$ %
email$$& +
,$$+ ,
string$$- 3
username$$4 <
)$$< =
{%% 	
var&& 
result&& 
=&& 
databaseService&& (
.&&( )
Users&&) .
.&&. /
Where&&/ 4
(&&4 5
i&&5 6
=>&&7 9
i&&: ;
.&&; <
Email&&< A
==&&B D
email&&E J
||&&K M
i&&N O
.&&O P
UserName&&P X
==&&Y [
username&&\ d
)&&d e
.&&e f
FirstOrDefault&&f t
(&&t u
)&&u v
;&&v w
if(( 
((( 
result(( 
==(( 
null(( 
)(( 
return)) 
false)) 
;)) 
return++ 
true++ 
;++ 
},, 	
}-- 
}.. ?!
PC:\Users\boris\source\repos\AmpleChat\API\AmpleChat API\AmpleChat API\Startup.cs
	namespace 	
AmpleChat_API
 
{ 
public 

class 
Startup 
{ 
public 
Startup 
( 
IConfiguration %
configuration& 3
)3 4
{ 	
Configuration 
= 
configuration )
;) *
} 	
public 
IConfiguration 
Configuration +
{, -
get. 1
;1 2
}3 4
public 
void 
ConfigureServices %
(% &
IServiceCollection& 8
services9 A
)A B
{ 	
services 
. 
AddCors 
( 
cors !
=>" $
{% &
cors 
. 
	AddPolicy 
( 
$str $
,$ %
policy& ,
=>- /
{0 1
policy 
. 
AllowAnyMethod )
() *
)* +
;+ ,
policy 
. 
AllowAnyHeader )
() *
)* +
;+ ,
policy 
. 
AllowAnyOrigin )
() *
)* +
;+ ,
} 
) 
; 
} 
) 
; 
services"" 
."" 
AddDbContext"" !
<""! "
DatabaseService""" 1
>""1 2
(""2 3
config""3 9
=>"": <
{""= >
config## 
.## 
UseSqlServer## #
(### $
Configuration##$ 1
[##1 2
$str##2 I
]##I J
)##J K
;##K L
}$$ 
)$$ 
;$$ 
services&& 
.&& 
AddTransient&& !
<&&! "
UserService&&" -
>&&- .
(&&. /
)&&/ 0
;&&0 1
services(( 
.(( 
AddControllers(( #
(((# $
)(($ %
;((% &
services)) 
.)) 
AddSwaggerGen)) "
())" #
c))# $
=>))% '
{** 
c++ 
.++ 

SwaggerDoc++ 
(++ 
$str++ !
,++! "
new++# &
OpenApiInfo++' 2
{++3 4
Title++5 :
=++; <
$str++= L
,++L M
Version++N U
=++V W
$str++X \
}++] ^
)++^ _
;++_ `
},, 
),, 
;,, 
}-- 	
public// 
void// 
	Configure// 
(// 
IApplicationBuilder// 1
app//2 5
,//5 6
IWebHostEnvironment//7 J
env//K N
)//N O
{00 	
if11 
(11 
env11 
.11 
IsDevelopment11 !
(11! "
)11" #
)11# $
{22 
app33 
.33 %
UseDeveloperExceptionPage33 -
(33- .
)33. /
;33/ 0
app44 
.44 

UseSwagger44 
(44 
)44  
;44  !
app55 
.55 
UseSwaggerUI55  
(55  !
c55! "
=>55# %
c55& '
.55' (
SwaggerEndpoint55( 7
(557 8
$str558 R
,55R S
$str55T f
)55f g
)55g h
;55h i
}66 
app99 
.99 
UseCors99 
(99 
$str99 
)99 
;99 
app== 
.== 
UseHttpsRedirection== #
(==# $
)==$ %
;==% &
app?? 
.?? 

UseRouting?? 
(?? 
)?? 
;?? 
appAA 
.AA 
UseAuthorizationAA  
(AA  !
)AA! "
;AA" #
appCC 
.CC 
UseEndpointsCC 
(CC 
	endpointsCC &
=>CC' )
{DD 
	endpointsEE 
.EE 
MapControllersEE (
(EE( )
)EE) *
;EE* +
}FF 
)FF 
;FF 
}GG 	
}HH 
}II 