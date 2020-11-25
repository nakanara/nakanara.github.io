@echo off

@rem ===============================================
@rem 디렉토리 생성 후 파일 복사 스크립트
@rem ===============================================


@rem 복사 경로
set target=C:\Temp\temp\patch_11
@rem 원본 경로
set src=D:\work_space\egene6.0


set file="src\main\webapp\xslm\jsp\ind\ind_summary.jsp"
@rem 문자열 변경
echo %file%

set file=%file:/=\% 
set t= %file%

set /a count= 1
set token = ""
echo %t%
echo %count%

cd %target%

@rem 가장 마지막 path를 제외하고는 폴더로 판단하고 생성 함

:loop
FOR /f "tokens=1* delims=\" %%a in (%t%) do (

  set token="%%a"
  set t="%%b"
  set /a count += 1
  echo "loop " %t% %count%
)

if NOT [%t%] == [""] (

  @rem 이동 및 디렉토리 생성
  echo %token%
  
  IF NOT EXIST %token% (
    echo "create folder"
    mkdir %token%
  )
  cd %token%
  echo "back"
  goto :loop
) 

@rem copy
copy %src%/%file% %targat%/%file% 

@rem https://ss64.com/nt/syntax-replace.html
@rem https://stackoverflow.com/questions/1707058/how-to-split-a-string-by-spaces-in-a-windows-batch-file