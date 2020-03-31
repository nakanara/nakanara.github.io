# Java 프로그램을 Lombok과 함께 하면 90%  쉬워짐

https://dev.to/jakehell/java-programming-is-90-easier-with-project-lombok-3d29

## 들어가며

자바로 프로그램을 작성하는 것은 힘듭니다. 간단한 코드조차도 장황합니다. Lombok(룸복)은 Java구문을 줄여줍니다. 룸복은 일반 자바 코드의 최대 90%까지 압축 될 수 있습니다. 

룸복을 사용하는 방법에 대해서 알아보시죠

## 준비

메이븐을 사용합니다. https://projectlombok.org/setup/maven

```xml
<dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
    <version>1.18.12</version>
    <scope>provided</scope>
</dependency>
```

이클립스 IDE에 추가하는 방법은 여기에 있습니다.
https://projectlombok.org/setup/eclipse


## 접근자 메서드들 정리 

IDE에서 생성한 수많은 getter, settter가 생성되었습니다.
그러나 이클립스에서 접근자를 만드는 것은 쉽지 않습니다. 룸복의 좋은점은 접근자 메소드를 생성할 필요성이 없습니다.

Class 전체의 접근자를 생성하는 방법

```java
@Getter
@Setter
public class GetterSetterExample {
  private int age = 10;
  private String name;
}
```

지정한 접근자 생성 방법

```java
public class GetterSetterExample {
  @Getter @Setter private int age = 10;

  @Setter(AccessLevel.PROTECTED) private String name;

  @Override public String toString() {
    return String.format("%s (age: %d)", name, age);
  }
}
```

##  Null 체크

항상 도움이 되지 않는 `NullPointerException`을 볼 때마다 스트레스입니다. `@NotNull` 속성으로 사용하면 쉽게 할 수 있습니다.

```java
public int getStringLength(@NonNull String str) {
    return str.length();
}
```

다음의 코드를 실행
```java
getStringLength(null);
```

다음의 결과를 얻을 수 있습니다.
```
Exception in thread "main" java.lang.NullPointerException: str is marked non-null but is null
```

## toString

Java 개발의 또 다른 단점은 toString 메소드입니다. 접근자 메소드와 마찬가지로 어노테이션만 있으면됩니다.

```java
@ToString(includeFieldNames = true)
public class Square {
    private final int width, height;

    public Square(int width, int height) {
        this.width = width;
        this.height = height;
    }
}
```

다음의 코드를 실행
```java
Square square = new Square(5, 10);
System.out.println(square.toString());
```
예상 결과는 다음과 같습니다.
```
Square(width=5, height=10)
```

