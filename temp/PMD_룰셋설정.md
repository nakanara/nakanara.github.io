
PMD 사이트 : https://pmd.github.io/
전자정부 권장 룰셋 : https://www.egovframe.go.kr/wiki/doku.php?id=egovframework:dev2:imp:inspection#%EC%A0%84%EC%9E%90%EC%A0%95%EB%B6%80_%ED%91%9C%EC%A4%80%ED%94%84%EB%A0%88%EC%9E%84%EC%9B%8C%ED%81%AC_%ED%91%9C%EC%A4%80_inspection_%EB%A3%B0%EC%85%8B


### AbstractClassWithoutAbstractMethod

추상 클래스에 추상화된 매소드가 없는 경우
https://pmd.github.io/pmd-6.34.0/pmd_rules_java_bestpractices.html#abstractclasswithoutabstractmethod

```
public abstract class Foo {
  void int method1() { ... }
  void int method2() { ... }
  // consider using abstract methods or removing
  // the abstract modifier and adding protected constructors
}
```

### AssignmentInOperand

연산자 내부(if 등)에서 값이 할당 됨
피연산자내에 할당문이 사용됨. 해당 코드를 복잡하고 가독성이 떨어지게 만듬

```java
public void bar() {
    int x = 2;
    if ((x = getX()) == 3) {
      System.out.println("3!");
    }
}
```

### AvoidArrayLoops

Array 값을 반복문을 이용한 복사는 비효율적, System.arraycopy 사용
https://pmd.github.io/latest/pmd_rules_java_performance.html#avoidarrayloops


```java
public class Test {
  public void bar() {
    int[] a = new int[10];
    int[] b = new int[10];
    for (int i=0;i<10;i++) {
      b[i]=a[i];
    }
    //그냥 다음과 같이 복사하자.
    System.arraycopy(a, 0, b, 0, a.length);
  }
}
```

### AvoidReassigningParameters

전달받은 파라미터 변경 탐지

```java
public class Foo {
  private void foo(String bar) {
    bar = "something else";
  }
}
```

### AvoidSynchronizedAtMethodLevel

mothod 레벨의 synchronization 보다 block 레벨 synchronization 을 사용하는 것이 바람직함

```java
public class Foo {
    // Try to avoid this:
    synchronized void foo() {
        // code, that doesn't need synchronization
        // ...
        // code, that requires synchronization
        if (!sharedData.has("bar")) {
            sharedData.add("bar");
        }
        // more code, that doesn't need synchronization
        // ...
    }
    // Prefer this:
    void bar() {
        // code, that doesn't need synchronization
        // ...
        synchronized(this) {
            if (!sharedData.has("bar")) {
                sharedData.add("bar");
            }
        }
        // more code, that doesn't need synchronization
        // ...
    }

    // Try to avoid this for static methods:
    static synchronized void fooStatic() {
    }

    // Prefer this:
    static void barStatic() {
        // code, that doesn't need synchronization
        // ...
        synchronized(Foo.class) {
            // code, that requires synchronization
        }
        // more code, that doesn't need synchronization
        // ...
    }
}
```

### AvoidThrowingNullPointerException

NullPointerException 을 throw하는 것 비추천

```java
public class Foo {
    void bar() {
        throw new NullPointerException();
    }
}
```

### AvoidThrowingRawExceptionTypes

가공되지 않은 Exception을 throw하는 것은 비추천


```java
public class Foo {
    public void bar() throws Exception {
        throw new Exception();
    }
}
```

### EmptyCatchBlock

내용 없는 예외 처리 블럭


``` java
public void doSomething() {
    try {
        FileInputStream fis = new FileInputStream("/tmp/bugger");
    } catch (IOException ioe) {
        // not good
    }
}
```

### EmptyFinallyBlock

내용 없는 finally 

```java
public class Foo {
    public void bar() {
        try {
            int x=2;
        } finally {
            // empty!
        }
    }
}
```


### EmptyIfStmt

내용 없는 조건 문

```java
public class Foo {
 void bar(int x) {
  if (x == 0) {
   // empty!
  }
 }
}
```

### EmptyStatementNotInLoop

의미 없는 세미클론

```java
public void doit() {
      // this is probably not what you meant to do
      ;
      // the extra semicolon here this is not necessary
      System.out.println("look at the extra semicolon");;
}
```

### EmptyTryBlock

내용 없는 예외 블록

```java
public class Foo {
    public void bar() {
        try {
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
```

### FinalFieldCouldBeStatic

final field를 static으로 변경하면 overhead를 줄일 수 있음

```java
public class Foo {
  public final int BAR = 42; // this could be static and save some space
}
```

### InefficientEmptyStringCheck

빈 문자열 확인을 위해 String.trim().length() 을 사용하는 것은 피하도록 함. whitespace/Non-whitespace 확인을 위한 별도의 로직 구현을 권장


```java
private boolean checkTrimEmpty(String str) {
    for(int i = 0; i < str.length(); i++) {
        if(!Character.isWhitespace(str.charAt(i))) {
            return false;
        }
    }
    return true;
}
```

### InefficientStringBuffering

StringBuffer 함수내에서 비문자열 연산 이용하여 직접 결합하는 코드 사용을 탐지. append 메소드 사용을 권장

문자열을 연산자가 아닌 append를 사용하여 결합

```java
// Avoid this, two buffers are actually being created here
StringBuffer sb = new StringBuffer("tmp = "+System.getProperty("java.io.tmpdir"));

// do this instead
StringBuffer sb = new StringBuffer("tmp = ");
sb.append(System.getProperty("java.io.tmpdir"));
```

### SimpleDateFormatNeedsLocale

SimpleDateFormat 인스턴스를 생성할때 Locale 을 지정하는 것이 바람직함

```java
public class Foo {
  // Should specify Locale.US (or whatever)
  private SimpleDateFormat sdf = new SimpleDateFormat("pattern");
}
```

### SimplifyBooleanExpressions

불필요 비교 연산자

```java
public class Bar {
  // can be simplified to
  // bar = isFoo();
  private boolean bar = (isFoo() == true);

  public isFoo() { return false;}
}
```

### StringInstantiation

불필요한 String instance 생성 코드, 간단한 형태의 코드로 변경 필요


```java
private String bar = new String("bar"); // just do a String bar = "bar";
```

### SwitchStmtsShouldHaveDefault

Switch 구문에는 default 가 존재 해야 함

```java
public void bar() {
    int x = 2;
    switch (x) {
      case 1: int j = 6;
      case 2: int j = 8;
          // missing default: here
    }
}
```

### SystemPrintln

System.out.println 사용보다 전용 로거 사용

```java
class Foo{
    Logger log = Logger.getLogger(Foo.class.getName());
    public void testA () {
        System.out.println("Entering test");
        // Better use this
        log.fine("Entering test");
    }
}
```

### UnnecessaryImport

미 사용 Import 제거, 중복 Import 제거 및 포괄적 Import 보다 개별 Import 권장

```java
import java.io.File;            // not used, can be removed
import java.util.Collections;   // used below
import java.util.*;             // so this one is not used

import java.lang.Object;        // imports from java.lang, unnecessary
import java.lang.Object;        // duplicate, unnecessary

public class Foo {
    static Object emptyList() {
        return Collections.emptyList();
    }
}
```


### 


```java

```
### 


```java

```


### 


```java

```
### 


```java

```


### 


```java

```
### 


```java

```


### 


```java

```