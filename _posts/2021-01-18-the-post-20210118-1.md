---
title: '[이클립스] Work Director(Catalina) 삭제'
layout: 
---

간혹 Include 된 대상을 수정하는 경우, 파일이 변경되었는지 판단하지 못해 컴파일이 안 되는 경우가 있다.
Tomcat을 통해 웹 서비스를 동작시키는 경우 전체 파일의 컴파일 필요하면 Catalina 디렉토리를 삭제하면 해당 페이지가 호출되는 시점에서 새로 컴파일을 한다.

```sh 
rm -rf Tomcat/work/Catalina/
```

특정 파일만 컴파일하고 싶다면 수정 일시를 변경한다.

``` sh
$ touch file.name
```

* 이클립스에서 Work Director 삭제

서버를 정지한 후 이클립스 하단 "Server" 탭에서 해당 서버를 선택 후 마우스 우클릭 "Clean Tomcat Work Director"로 진행한다.

해당 서버의 Catalina 경로는 workspace 아래 위치하고 있다.
```
${WORK_SPACE}\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\work\Catalina\localhost
```

#tomcat #catalina #workdirector #NoClassDefFoundError  #eclipse