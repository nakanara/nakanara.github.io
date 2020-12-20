@echo off

@rem ===============================================
@rem 디렉토리 생성 후 파일 복사 스크립트
@rem ===============================================


rem 복사 대상 시작 경로
rem set target=C:\Temp\temp\patch_20201218
set target=%cd%

rem 소스 시작 경로
set src=D:\work_space\egene6.0

rem 입력 받은 파일 경로
set file="%1"
echo %file%

rem 문자열 변경
set file=%file:/=\% 
set t=%file%

set count=1
set token=""

cd %target%

rem 가장 마지막 path를 제외하고는 폴더로 판단하고 생성 함
rem 
rem tokens 1,* 첫번째 값을 %%a에 그 외값은 %%b 에 입력, 1회만 돌아감

:loop
FOR /f "tokens=1,* delims=\" %%a in (%t%) do (

  set token="%%a"
  set t="%%b"
  set /a count += 1
  @rem echo "loop " %t% %count%
)
echo "1"
if NOT [%t%] == [""] (

  @rem 이동 및 디렉토리 생성
  @rem echo %token%
  
  IF NOT EXIST %token% (
    @rem echo "create folder"
    mkdir %token%
  )
  cd %token%
  goto :loop
) 

@rem copy
echo %src%\%file% %target%\%file%
copy %src%\%file% %target%\%file% 

cd %target%

@rem https://ss64.com/nt/for_f.html
@rem https://ss64.com/nt/syntax-replace.html
@rem https://stackoverflow.com/questions/1707058/how-to-split-a-string-by-spaces-in-a-windows-batch-file