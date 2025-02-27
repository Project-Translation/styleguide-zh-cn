# Google Objective-C 风格指南

> Objective-C 是 C 语言的动态、面向对象的扩展。它设计得易于使用和阅读，同时支持复杂的面向对象设计。它是 Apple 平台应用程序的主要开发语言之一。
>
> Apple 已经编写了一份非常好且广泛接受的 [Cocoa 编码指南](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/CodingGuidelines/CodingGuidelines.html)，适用于 Objective-C。请在阅读本指南的同时参考该指南。
>
> 本文档的目的是描述 Objective-C（以及 Objective-C++）的编码指南和实践。这些指南经过长时间的演变和在其他项目及团队中的验证。Google 开发的开源项目符合本指南中的要求。
>
> 请注意，本指南并非 Objective-C 教程。我们假设读者已经熟悉该语言。如果您是 Objective-C 新手或需要复习，请阅读 [使用 Objective-C 编程](https://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Introduction/Introduction.html)。



## 原则

### 为读者优化，而非作者

代码库通常具有较长的生命周期，阅读代码的时间远多于编写代码的时间。我们明确选择优化我们平均软件工程师在代码库中阅读、维护和调试代码的体验，而不是编写代码的便利性。例如，当代码片段中发生令人惊讶或不寻常的事情时，为读者留下文本提示是很有价值的。

### 保持一致性

当风格指南允许多种选择时，最好选择一种选项而不是混合使用多种选项。在整个代码库中一致地使用一种风格可以让工程师专注于其他（更重要）的议题。一致性还可以更好地实现自动化，因为一致的代码允许更有效地开发和操作格式化或重构代码的工具。在许多情况下，归因于“保持一致性”的规则归结为“选择一种并停止担心”；允许在这些点上灵活性的潜在价值被人们争论这些问题的成本所抵消。

### 与 Apple SDK 保持一致

与 Apple SDK 使用 Objective-C 的方式保持一致具有与我们代码库内部一致性相同的价值。如果 Objective-C 功能解决了一个问题，那就是使用它的理由。然而，有时语言功能和习惯用法存在缺陷，或者只是基于不普遍的假设设计的。在这些情况下，限制或禁止使用语言功能或习惯用法是合适的。

### 风格规则应发挥其作用

风格规则的益处必须足够大，以证明要求工程师记住它是合理的。益处是相对于没有该规则时我们将得到的代码库来衡量的，因此，如果人们不太可能做某件非常有害的事情，那么反对这种做法的规则可能仍然只有很小的益处。这一原则主要解释了我们没有的规则，而不是我们有的规则：例如，goto 违反了许多以下原则，但由于其极端罕见性而未被讨论。

<a id="Example"></a>
## 示例

俗话说，一个例子胜过千言万语，所以我们先从一个例子开始，让你感受一下风格、间距、命名等方面的特点。

这是一个示例头文件，展示了 `@interface` 声明的正确注释和间距。

```objectivec
// 良好示例：

#import <Foundation/Foundation.h>

@class Bar;

/**
 * 一个展示良好 Objective-C 风格的示例类。所有接口、
 * 类别和协议（阅读：头文件中所有非平凡的顶级声明）
 * 必须有注释。注释也必须紧邻它们所记录的对象。
 */
@interface Foo : NSObject

/** 保留的 Bar。 */
@property(nonatomic) Bar *bar;

/** 当前的绘图属性。 */
@property(nonatomic, copy) NSDictionary<NSString *, NSNumber *> *attributes;

/**
 * 便捷创建方法。
 * 有关 @c bar 的详细信息，请参见 -initWithBar:。
 *
 * @param bar 用于 fooing 的字符串。
 * @return Foo 的实例。
 */
+ (instancetype)fooWithBar:(Bar *)bar;

/**
 * 使用提供的 Bar 实例初始化并返回一个 Foo 对象。
 *
 * @param bar 表示一个执行某操作的字符串。
 */
- (instancetype)initWithBar:(Bar *)bar NS_DESIGNATED_INITIALIZER;

/**
 * 使用 @c blah 执行一些工作。
 *
 * @param blah
 * @return 如果工作完成则返回 YES；否则返回 NO。
 */
- (BOOL)doWorkWithBlah:(NSString *)blah;

@end
```

这是一个示例源文件，展示了接口 `@implementation` 的正确注释和间距。

```objectivec
// 良好示例：

#import "Shared/Util/Foo.h"

@implementation Foo {
  /** 用于显示“hi”的字符串。 */
  NSString *_string;
}

+ (instancetype)fooWithBar:(Bar *)bar {
  return [[self alloc] initWithBar:bar];
}

- (instancetype)init {
  // 具有自定义指定初始化器的类应始终覆盖超类的指定初始化器。
  return [self initWithBar:nil];
}

- (instancetype)initWithBar:(Bar *)bar {
  self = [super init];
  if (self) {
    _bar = [bar copy];
    _string = [[NSString alloc] initWithFormat:@"hi %d", 3];
    _attributes = @{
      @"color" : UIColor.blueColor,
      @"hidden" : @NO
    };
  }
  return self;
}

- (BOOL)doWorkWithBlah:(NSString *)blah {
  // 应在此处执行工作。
  return NO;
}

@end
```

<a id="Naming"></a>

## 命名

名称应尽可能描述性强，但在合理范围内。遵循标准的 [Objective-C 命名规则](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/CodingGuidelines/CodingGuidelines.html)。

避免使用非标准缩写（包括非标准首字母缩写词和缩写词）。不要担心节省水平空间，因为让新读者立即理解你的代码更为重要。例如：

```objectivec
// 良好示例：

// 良好的名称。
int numberOfErrors = 0;
int completedConnectionsCount = 0;
tickets = [[NSMutableArray alloc] init];
userInfo = [someObject object];
port = [network port];
NSDate *gAppLaunchDate;
```

```objectivec
// 避免：

// 应避免的名称。
int w;
int nerr;
int nCompConns;
tix = [[NSMutableArray alloc] init];
obj = [someObject object];
p = [network port];
```

任何类、类别、方法、函数或变量名称应在名称中（包括名称开头）对首字母缩写词和[缩写词](https://en.wikipedia.org/wiki/Initialism)使用全大写。这遵循 Apple 使用 URL、ID、TIFF 和 EXIF 等首字母缩写词在名称中全大写的标准。

C 函数和 typedef 的名称应大写并根据周围代码适当使用驼峰命名法。

<a id="Inclusive_Language"></a>

### 包容性语言

在所有代码中，包括命名和注释，使用包容性语言，避免使用其他程序员可能认为不尊重或冒犯的术语（如“master”和“slave”、“blacklist”和“whitelist”，或“redline”），即使这些术语也有表面上中性的含义。同样，除非你指的是特定的人（并使用他们的代词），否则使用性别中立的语言。例如，对于未指定性别的人使用“they”/“them”/“their”（即使是单数），对于非人使用“it”/“its”。

<a id="File_Names"></a>
### 文件名

文件名应反映它们所包含的类实现的名称，包括大小写。

遵循项目使用的惯例。

文件扩展名应如下所示：

扩展名 | 类型
--------- | ---------------------------------
.h        | C/C++/Objective-C 头文件
.m        | Objective-C 实现文件
.mm       | Objective-C++ 实现文件
.cc       | 纯 C++ 实现文件
.c        | C 实现文件

包含可能在多个项目之间共享或在大型项目中使用的代码的文件应具有明显独特的名称，通常包括项目或类[前缀](#prefixes)。

类别的文件名应包括被扩展的类的名称，例如 GTMNSString+Utils.h 或 NSTextView+GTMAutocomplete.h

### 前缀

在 Objective-C 中，通常需要前缀以避免全局命名空间中的命名冲突。类、协议、全局函数和全局常量通常应使用以大写字母开头，后跟一个或多个大写字母或数字的前缀进行命名。

警告：Apple 保留了两字母前缀——参见[Objective-C 编程中的惯例](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Conventions/Conventions.html)——因此，最佳实践是使用至少三个字符的前缀。

```objectivec
// 良好示例：

/** 一个示例错误域。 */
GTM_EXTERN NSString *GTMExampleErrorDomain;

/** 获取默认时区。 */
GTM_EXTERN NSTimeZone *GTMGetDefaultTimeZone(void);

/** 一个示例委托。 */
@protocol GTMExampleDelegate <NSObject>
@end

/** 一个示例类。 */
@interface GTMExample : NSObject
@end

```

<a id="Class_Names"></a>

### 类名

类名（连同类别和协议名）应以大写字母开头，并使用混合大小写来分隔单词。

在多个应用程序之间共享的代码中的类和协议必须有一个适当的[前缀](#prefixes)（例如 GTMSendMessage）。对于其他类和协议，建议但不要求使用前缀。

<a id="Category_Names"></a>

### 类别命名

类别名应以一个适当的[前缀](#prefixes)开头，以识别该类别属于某个项目或供一般使用。

类别源文件名应以被扩展的类开头，后跟加号和类别名称，例如 `NSString+GTMParsing.h`。类别中的方法应使用类别名称前缀的小写版本加上下划线作为前缀（例如，`gtm_myCategoryMethodOnAString:`），以防止在 Objective-C 的全局命名空间中发生冲突。

类名与类别括号之间应有一个空格。

```objectivec
// 良好示例：

// UIViewController+GTMCrashReporting.h

/** 向 UIViewController 添加用于崩溃报告的元数据的类别。 */
@interface UIViewController (GTMCrashReporting)

/** 在崩溃报告中表示视图控制器的唯一标识符。 */
@property(nonatomic, setter=gtm_setUniqueIdentifier:) int gtm_uniqueIdentifier;

/** 返回视图控制器当前状态的编码表示。 */
- (nullable NSData *)gtm_encodedState;

@end
```

如果一个类不与其他项目共享，则扩展它的类别可以省略名称前缀和方法名称前缀。

```objectivec
// 良好示例：

/** 此类别扩展了一个不与其他项目共享的类。 */
@interface XYZDataObject (Storage)
- (NSString *)storageIdentifier;
@end
```

<a id="Objective-C_Method_Names"></a>
### Objective-C 方法命名

方法和参数名称通常以小写字母开头，然后使用混合大小写。

应尊重正确的首字母大写，包括名称的开头。

```objectivec
// 良好：

+ (NSURL *)URLWithString:(NSString *)URLString;
```

如果可能，方法名称应像句子一样阅读，这意味着您应选择与方法名称相呼应的参数名称。Objective-C 方法名称往往很长，但这有一个好处，即一段代码几乎可以像散文一样阅读，从而使许多实现注释变得不必要。

在第二个及以后的参数名称中，仅在必要时使用介词和连词，如“with”、“from”和“to”，以澄清方法的含义或行为。

```objectivec
// 良好：

- (void)addTarget:(id)target action:(SEL)action;                          // 良好；不需要连词
- (CGPoint)convertPoint:(CGPoint)point fromView:(UIView *)view;           // 良好；连词澄清了参数
- (void)replaceCharactersInRange:(NSRange)aRange
            withAttributedString:(NSAttributedString *)attributedString;  // 良好。
```

如果方法返回接收者的属性，则应将方法命名为该属性。

```objectivec
// 良好：

/** 返回此实例的三明治。 */
- (Sandwich *)sandwich;      // 良好。

- (CGFloat)height;           // 良好。

// 良好；返回值不是属性。
- (UIBackgroundTaskIdentifier)beginBackgroundTask;
```

```objectivec
// 避免：

- (CGFloat)calculateHeight;  // 避免。
- (id)theDelegate;           // 避免。
```

访问器方法的名称应与其获取的对象相同，但不应以`get`为前缀。例如：

```objectivec
// 良好：

- (id)delegate;     // 良好。
```

```objectivec
// 避免：

- (id)getDelegate;  // 避免。
```

返回布尔形容词值的访问器方法的名称应以`is`开头，但这些方法的属性名称应省略`is`。

点表示法仅用于属性名称，不用于方法名称。

```objectivec
// 良好：

@property(nonatomic, getter=isGlorious) BOOL glorious;
// 上述属性的getter方法为：
// - (BOOL)isGlorious;

BOOL isGood = object.glorious;      // 良好。
BOOL isGood = [object isGlorious];  // 良好。
```

```objectivec
// 避免：

BOOL isGood = object.isGlorious;    // 避免。
```

```objectivec
// 良好：

NSArray<Frog *> *frogs = [NSArray<Frog *> arrayWithObject:frog];
NSEnumerator *enumerator = [frogs reverseObjectEnumerator];  // 良好。
```

```objectivec
// 避免：

NSEnumerator *enumerator = frogs.reverseObjectEnumerator;    // 避免。
```

有关Objective-C命名方法的更多详细信息，请参阅[Apple的命名方法指南](https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/CodingGuidelines/Articles/NamingMethods.html#//apple_ref/doc/uid/20001282-BCIGIJJF)。

这些指南仅适用于Objective-C方法。C++方法名称继续遵循C++风格指南中的规则。

<a id="Function_Names"></a>

### 函数命名

函数名称应以大写字母开头，每个新单词也应大写字母开头（即“[驼峰命名法](https://en.wikipedia.org/wiki/Camel_case)”或“Pascal命名法”）。

```objectivec
// 良好：

static void AddTableEntry(NSString *tableEntry);
static BOOL DeleteFile(const char *filename);
```

由于Objective-C不提供命名空间，非静态函数应有一个[前缀](#prefixes)，以尽量减少名称冲突的可能性。

```objectivec
// 良好：

GTM_EXTERN NSTimeZone *GTMGetDefaultTimeZone(void);
GTM_EXTERN NSString *GTMGetURLScheme(NSURL *URL);
```

<a id="Variable_Names"></a>
### 变量命名

变量名通常以小写字母开头，并使用混合大小写来分隔单词。

实例变量以前导下划线开头。文件作用域或全局变量应带有前缀 `g`。例如：`myLocalVariable`、`_myInstanceVariable`、`gMyGlobalVariable`。

<a id="Common_Variable_Names"></a>

#### 常见变量命名

读者应能从变量名中推断出变量类型，但不要使用匈牙利命名法来表示语法属性，如变量的静态类型（如 int 或指针）。

文件作用域或全局变量（相对于常量）在方法或函数作用域之外声明应很少见，且应带有前缀 `g`。

```objectivec
// 良好：

static int gGlobalCounter;
```

<a id="Instance_Variables"></a>

#### 实例变量

实例变量名应使用混合大小写，并以前导下划线开头，如 `_usernameTextField`。

注意：谷歌之前对 Objective-C 实例变量的命名约定是使用尾随下划线。现有项目可以选择在新代码中继续使用尾随下划线，以保持项目代码库的一致性。每个类内部应保持前缀或后缀下划线的一致性。

<a id="Constants"></a>

#### 常量

常量符号（const 全局和静态变量以及使用 #define 创建的常量）应使用混合大小写来分隔单词。

全局和文件作用域的常量应有适当的[前缀](#prefixes)。

```objectivec
// 良好：

/** GTL 服务错误的域。 */
GTL_EXTERN NSString *const GTLServiceErrorDomain;

/** GTL 服务错误代码的枚举。 */
typedef NS_ENUM(int32_t, GTLServiceError) {
  /** 表示查询结果缺失的错误代码。 */
  GTLServiceErrorQueryResultMissing = -3000,
  /** 表示查询超时的错误代码。 */
  GTLServiceErrorQueryTimedOut      = -3001,
};
```

由于 Objective-C 不提供命名空间，具有外部链接的常量应有一个前缀，以尽量减少名称冲突的可能性，通常如 `ClassNameConstantName` 或 `ClassNameEnumName`。

为了与 Swift 代码的互操作性，枚举值应具有扩展 typedef 名称的名称：

```objectivec
// 良好：

/** 支持的显示色调的枚举。 */
typedef NS_ENUM(int32_t, DisplayTinge) {
  DisplayTingeGreen = 1,
  DisplayTingeBlue = 2,
};
```

在实现文件中声明的静态存储期常量可以使用小写的 k 作为独立前缀：

```objectivec
// 良好：

static const int kFileCount = 12;
static NSString *const kUserKey = @"kUserKey";
```

注意：之前的约定是公共常量名称以小写的 k 开头，后跟项目特定的[前缀](#prefixes)。这种做法已不再推荐。

<a id="Types_and_Declarations"></a>

## 类型和声明

<a id="Method_Declarations"></a>

### 方法声明

如[示例](#Example)所示，`@interface` 声明中推荐的声明顺序为：属性、类方法、初始化方法，最后是实例方法。类方法部分应以任何便捷构造函数开始。

<a id="Local_Variables"></a>

### 局部变量

在最窄的实际范围内声明变量，并尽量靠近其使用位置。在声明时初始化变量。

```objectivec
// 良好：

CLLocation *location = [self lastKnownLocation];
for (int meters = 1; meters < 10; meters++) {
  reportFrogsWithinRadius(location, meters);
}
```

有时，为了效率，声明变量的位置可能更适合在其使用范围之外。此示例将 meters 声明与初始化分开，并且每次循环时不必要地发送 lastKnownLocation 消息：

```objectivec
// 避免：

int meters;                                         // 避免。
for (meters = 1; meters < 10; meters++) {
  CLLocation *location = [self lastKnownLocation];  // 避免。
  reportFrogsWithinRadius(location, meters);
}
```

在自动引用计数下，强引用和弱引用到 Objective-C 对象的指针会自动初始化为 `nil`，因此对于这些常见情况，不需要显式地初始化为 `nil`。然而，自动初始化不会发生在许多 Objective-C 指针类型上，包括使用 `__unsafe_unretained` 所有权限定符声明的对象指针和 CoreFoundation 对象指针类型。当有疑问时，建议初始化所有 Objective-C 局部变量。
### 静态变量

当实现文件中的文件范围变量/常量声明不需要在该文件之外引用时，请将它们声明为静态（或在 Objective-C++ 中使用匿名命名空间）。不要在 .h 文件中声明具有静态存储持续时间的文件范围变量或常量（或在 Objective-C++ 中使用匿名命名空间）。

```objectivec
// 正确：

// 文件：Foo.m
static const int FOORequestLimit = 5;
```

```objectivec
// 避免：

// 文件：Foo.h
static const int FOORequestLimit = 5;  // 避免。
```

<a id="Unsigned_Integers"></a>

### 无符号整数

除非与系统接口使用的类型匹配，否则应避免使用无符号整数。

在使用无符号整数进行数学运算或倒计时到零时，可能会出现细微的错误。除了与系统接口中的 NSUInteger 匹配外，数学表达式中只应使用有符号整数。

```objectivec
// 正确：

NSUInteger numberOfObjects = array.count;
for (NSInteger counter = numberOfObjects - 1; counter >= 0; --counter)
```

```objectivec
// 避免：

for (NSUInteger counter = numberOfObjects - 1; counter >= 0; --counter)  // 避免。
```

无符号整数可用于标志和位掩码，尽管通常 NS_OPTIONS 或 NS_ENUM 会更合适。

<a id="Types_with_Inconsistent_Sizes"></a>

### 大小不一致的类型

请注意，类型 long、NSInteger、NSUInteger 和 CGFloat 在 32 位和 64 位构建中的大小不同。它们在与系统接口匹配时使用是合适的，但在处理需要精确大小的 API（例如 proto API）时应避免使用。

```objectivec
// 正确：

int32_t scalar1 = proto.intValue;

int64_t scalar2 = proto.longValue;

NSUInteger numberOfObjects = array.count;

CGFloat offset = view.bounds.origin.x;
```

```objectivec
// 避免：

NSInteger scalar2 = proto.longValue;  // 避免。
```

文件和缓冲区大小通常会超过 32 位限制，因此应使用 `int64_t` 声明，而不是使用 `long`、`NSInteger` 或 `NSUInteger`。

<a id="Floating_Point_Constants"></a>

#### 浮点常量

在定义 `CGFloat` 常量时，请注意以下几点。

以前，对于针对 32 位平台的项目，可能需要使用 `float` 字面量（带有 `f` 后缀的数字）来避免类型转换警告。

由于所有 Google iOS 项目现在仅针对 64 位运行时，`CGFloat` 常量可以省略后缀（使用 `double` 值）。然而，团队可以选择继续使用 `float` 数字以保持遗留代码的一致性，直到最终迁移到所有地方都使用 `double` 值。避免在同一代码中混合使用 `float` 和 `double` 值。

```objectivec
// 正确：

// 由于 CGFloat 是 double，因此正确
static const CGFloat kHorizontalMargin = 8.0;
static const CGFloat kVerticalMargin = 12.0;

// 只要项目中所有 CGFloat 常量的值都是 float，这也是可以的
static const CGFloat kHorizontalMargin = 8.0f;
static const CGFloat kVerticalMargin = 12.0f;
```

```objectivec
// 避免：

// 避免混合使用 float 和 double 常量
static const CGFloat kHorizontalMargin = 8.0f;
static const CGFloat kVerticalMargin = 12.0;
```

<a id="Comments"></a>

## 注释

注释对于保持代码的可读性至关重要。以下规则描述了您应该在哪里以及如何进行注释。但请记住：虽然注释很重要，但最好的代码是自文档化的。给类型和变量赋予有意义的名称远比使用晦涩的名称然后通过注释来解释它们要好得多。

请注意标点符号、拼写和语法；阅读写得好的注释比阅读写得差的注释更容易。

注释应该像叙述性文本一样易读，具有适当的大写和标点符号。在许多情况下，完整的句子比句子片段更易读。较短的注释，例如代码行末尾的注释，有时可以不那么正式，但请使用一致的风格。

在编写注释时，请为您的读者写作：下一个需要理解您的代码的贡献者。请慷慨一些——下一个可能是您自己！

<a id="File_Comments"></a>

### 文件注释

文件可以选择性地以对其内容的描述开始。

每个文件可以按顺序包含以下项目：
  * 如果需要，许可证样板。根据项目使用的许可证选择适当的样板。
  * 如果需要，对文件内容的基本描述。

如果您对带有作者行的文件进行了重大更改，请考虑删除作者行，因为修订历史已经提供了更详细和准确的 authorship 记录。

<a id="Declaration_Comments"></a>
### 声明注释

每个非平凡的接口，无论是公共的还是私有的，都应该有一个伴随的注释，描述其用途及其在更大背景中的位置。

注释应用于记录类、属性、实例变量、函数、类别、协议声明和枚举。

```objectivec
// 良好示例：

/**
 * NSApplication 的委托，用于处理关于应用启动和关闭的通知。由主应用控制器拥有。
 */
@interface MyAppDelegate : NSObject {
  /**
   * 正在进行的后台任务，如果有的话。初始化为 UIBackgroundTaskInvalid 的值。
   */
  UIBackgroundTaskIdentifier _backgroundTaskID;
}

/** 为应用创建和管理获取器的工厂。 */
@property(nonatomic) GTMSessionFetcherService *fetcherService;

@end
```

鼓励使用[Doxygen](https://doxygen.nl)风格的注释来描述接口，因为它们可以被 Xcode 解析并显示格式化的文档。Doxygen 提供了多种[命令](https://www.doxygen.nl/manual/commands.html)；在项目中应一致使用这些命令。

如果您已经在文件顶部的注释中详细描述了一个接口，可以简单地说明，“请参阅文件顶部的注释以获取完整描述”，但请确保有一定形式的注释。

此外，每个方法都应该有一个注释，解释其功能、参数、返回值、线程或队列假设以及任何副作用。公共方法的文档注释应放在头文件中，而非平凡的私有方法的注释应紧接在方法之前。

在方法和函数的注释中，使用描述性形式（“打开文件”）而不是命令式形式（“打开文件”）。注释描述函数的作用，而不是告诉函数该做什么。

如果类、属性或方法有关于线程使用的假设，请在文档中说明。如果类的实例可以被多个线程访问，请特别注意记录关于多线程使用的规则和不变量。

对于属性和实例变量的任何哨兵值，如 `NULL` 或 `-1`，应在注释中进行记录。

声明注释解释了如何使用方法或函数。解释方法或函数如何实现的注释应与实现一起，而不是与声明一起。

如果注释不会传达超出方法名称之外的额外信息，可以省略测试用例类和测试方法的声明注释。测试或测试特定类（如辅助函数）中的实用方法应添加注释。

<a id="Implementation_Comments"></a>

### 实现注释

为代码中棘手、微妙或复杂的部分提供解释性注释。

```objectivec
// 良好示例：

// 在调用完成处理程序之前将属性设置为 nil，以避免重入导致回调再次被调用的风险。
CompletionHandler handler = self.completionHandler;
self.completionHandler = nil;
handler();
```

在有用时，也可以提供关于考虑过或放弃的实现方法的注释。

行尾注释应与代码至少隔开两个空格。如果您在连续几行上有多个注释，通常将它们对齐会更易读。

```objectivec
// 良好示例：

[self doSomethingWithALongName];  // 注释前有两个空格。
[self doSomethingShort];          // 更多的空格以对齐注释。
```

<a id="Disambiguating_Symbols"></a>

### 消除符号歧义

在需要避免歧义的地方，使用反引号或垂直条来引用注释中的变量名和符号，而不是使用引号或内联命名符号。

在 Doxygen 风格的注释中，优先使用单间距文本命令（如 [`@c`](https://www.doxygen.nl/manual/commands.html#cmdc)）来标示符号。

标示有助于在符号是一个常见词时提供清晰度，这可能会使句子看起来像是构造不当。一个常见的例子是符号 `count`：

```objectivec
// 良好示例：

// 有时 `count` 会小于零。
```

或者在引用已经包含引号的内容时：

```objectivec
// 良好示例：

// 记得调用 `StringWithoutSpaces("foo bar baz")`
```

当符号本身显而易见时，不需要使用反引号或垂直条。

```objectivec
// 良好示例：

// 这个类作为 GTMDepthCharge 的委托。
```

Doxygen 格式也适合标识符号。

```objectivec
// 良好示例：

/** @param maximum @c count 的最高值。 */
```

<a id="Object_Ownership"></a>
### 对象所有权

对于不受 ARC 管理的对象，应尽可能明确地指出指针所有权模型，尤其是在超出最常见的 Objective-C 使用习惯时。

<a id="Manual_Reference_Counting"></a>

#### 手动引用计数

NSObject 派生对象的实例变量被假定为已保留；如果它们未被保留，则应注释为弱引用或使用 `__weak` 生命周期限定符声明。

例外情况是在 Mac 软件中标记为 `@IBOutlets` 的实例变量，这些变量被假定为未被保留。

对于指向 Core Foundation、C++ 和其他非 Objective-C 对象的实例变量，应始终使用强引用和弱引用的注释来声明，以指示哪些指针已被保留，哪些未被保留。Core Foundation 和其他非 Objective-C 对象指针需要显式的内存管理，即使是在为自动引用计数构建时也是如此。

强引用和弱引用的声明示例：

```objectivec
// 良好：

@interface MyDelegate : NSObject

@property(nonatomic) NSString *doohickey;
@property(nonatomic, weak) NSString *parent;

@end


@implementation MyDelegate {
  IBOutlet NSButton *_okButton;  // 普通 NSControl；仅在 Mac 上隐式弱引用

  AnObjcObject *_doohickey;  // 我的小玩意
  __weak MyObjcParent *_parent;  // 用于发送消息回（拥有此实例）

  // 非 NSObject 指针...
  CWackyCPPClass *_wacky;  // 强引用，一些跨平台对象
  CFDictionaryRef *_dict;  // 强引用
}
@end
```

<a id="Automatic_Reference_Counting"></a>

#### 自动引用计数

使用 ARC 时，对象所有权和生命周期是明确的，因此对于自动保留的对象不需要额外的注释。

<a id="C_Language_Features"></a>

## C 语言特性

<a id="Macros"></a>

### 宏

尽量避免使用宏，特别是当可以使用 `const` 变量、枚举、Xcode 代码片段或 C 函数时。

宏使得你看到的代码与编译器看到的代码不同。现代 C 使得传统上使用宏定义常量和实用函数变得不必要。只有在没有其他解决方案时才应使用宏。

在需要宏时，使用唯一名称以避免在编译单元中发生符号冲突。如果可行，通过在使用后 `#undef` 宏来限制其作用域。

宏名称应使用 `SHOUTY_SNAKE_CASE`——全大写字母并用下划线分隔单词。类似函数的宏可以使用 C 函数命名惯例。不要定义看起来像 C 或 Objective-C 关键字的宏。

```objectivec
// 良好：

#define GTM_EXPERIMENTAL_BUILD ...      // 良好

// 除非 X > Y，否则断言
#define GTM_ASSERT_GT(X, Y) ...         // 良好，宏风格。

// 除非 X > Y，否则断言
#define GTMAssertGreaterThan(X, Y) ...  // 良好，函数风格。
```

```objectivec
// 避免：

#define kIsExperimentalBuild ...        // 避免

#define unless(X) if(!(X))              // 避免
```

避免扩展为不平衡的 C 或 Objective-C 结构的宏。避免引入作用域的宏，或可能模糊块中值捕获的宏。

避免在头文件中生成类、属性或方法定义的宏，这些宏用作公共 API。这些只会使代码难以理解，语言已经有更好的方法来做这件事。

避免生成方法实现的宏，或生成后来在宏外部使用的变量声明的宏。宏不应通过隐藏变量的声明位置和方式来使代码难以理解。

```objectivec
// 避免：

#define ARRAY_ADDER(CLASS) \
  -(void)add ## CLASS ## :(CLASS *)obj toArray:(NSMutableArray *)array

ARRAY_ADDER(NSString) {
  if (array.count > 5) {              // 避免 -- 'array' 在哪里定义的？
    ...
  }
}
```

可接受的宏使用示例包括基于构建设置有条件编译的断言和调试日志宏——通常，这些不会编译到发布构建中。

<a id="Nonstandard_Extensions"></a>
### 非标准扩展

除非另有说明，否则不得使用C/Objective-C的非标准扩展。

编译器支持各种不属于标准C的扩展。例如，复合语句表达式（例如 `foo = ({ int x; Bar(&x); x })`）。

#### `__typeof__` 关键字

在类型对读者理解无帮助的情况下，允许使用 `__typeof__` 关键字。鼓励使用 `__typeof__` 关键字而不是其他类似的关键字（例如 `typeof` 关键字），因为它在所有语言变体中都得到支持。

```objectivec
// 推荐：

  __weak __typeof__(self) weakSelf = self;
```

```objectivec
// 避免：

  __typeof__(data) copiedData = [data copy];  // 避免。
  __weak typeof(self) weakSelf = self;        // 避免。
```

#### `__auto_type` 关键字和类型推断

仅允许对块和函数指针类型的局部变量使用 `__auto_type` 关键字进行类型推断。如果已存在块或指针类型的 typedef，则避免类型推断。

```objectivec
// 推荐：

__auto_type block = ^(NSString *arg1, int arg2) { ... };
__auto_type functionPointer = &MyFunction;

typedef void(^SignInCallback)(Identity *, NSError *);
SignInCallback signInCallback = ^(Identity *identity, NSError *error) { ... };
```

```objectivec
// 避免：

__auto_type button = [self createButtonForInfo:info];
__auto_type viewController = [[MyCustomViewControllerClass alloc] initWith...];

typedef void(^SignInCallback)(Identity *, NSError *);
__auto_type signInCallback = ^(Identity *identity, NSError *error) { ... };
```

#### 批准的非标准扩展

*   `__attribute__` 关键字被批准使用，因为它在 Apple API 声明中使用。
*   条件运算符的二进制形式，`A ?: B`，被批准使用。

<a id="Cocoa_and_Objective-C_Features"></a>

## Cocoa 和 Objective-C 特性

<a id="Identify_Designated_Initializer"></a>

### 识别指定初始化器

明确识别您的指定初始化器。

对于子类化来说，一个类明确识别其指定初始化器非常重要。这允许子类覆盖一部分初始化器来初始化子类状态或调用子类提供的新指定初始化器。明确识别的指定初始化器还可以使跟踪和调试初始化代码变得更容易。

优先通过使用指定初始化器属性（例如 `NS_DESIGNATED_INITIALIZER`）来标注指定初始化器。在无法使用指定初始化器属性时，在注释中声明指定初始化器。除非有令人信服的理由或要求，否则优先使用单一指定初始化器。

通过[覆盖超类指定初始化器](#Override_Designated_Initializer)来支持从超类继承的初始化器，以确保所有继承的初始化器都通过子类指定初始化器进行处理。当有令人信服的理由或要求不支持继承的初始化器时，可以使用可用性属性（例如 `NS_UNAVAILABLE`）来标注初始化器以阻止使用；然而，请注意，仅使用可用性属性并不能完全防止无效初始化。

<a id="Override_Designated_Initializer"></a>

### 覆盖指定初始化器

在编写需要新指定初始化器的子类时，确保覆盖超类的任何指定初始化器。

在类上声明指定初始化器时，请记住，任何在超类上被视为指定初始化器的初始化器，除非另有声明，否则将成为子类的便捷初始化器。未能覆盖超类指定初始化器可能会导致由于使用超类初始化器进行无效初始化而产生的错误。为了避免无效初始化，确保便捷初始化器调用指定初始化器。

<a id="Overridden_NSObject_Method_Placement"></a>

### 覆盖 NSObject 方法的位置

将覆盖的 NSObject 方法放在 `@implementation` 的顶部。

这通常适用于（但不限于）`init...`、`copyWithZone:` 和 `dealloc` 方法。`init...` 方法应集中在一起，包括那些不是 NSObject 覆盖的 `init...` 方法，其次是其他典型的 NSObject 方法，如 `description`、`isEqual:` 和 `hash`。

用于创建实例的便捷类工厂方法可以放在 NSObject 方法之前。

<a id="Initialization"></a>
### 初始化

不要在 `init` 方法中将实例变量初始化为 `0` 或 `nil`；这样做是多余的。

对于新分配的对象，所有实例变量都被[初始化为](https://developer.apple.com/library/mac/documentation/General/Conceptual/CocoaEncyclopedia/ObjectAllocation/ObjectAllocation.html) `0`（`isa` 除外），因此不要通过将变量重新初始化为 `0` 或 `nil` 来使 `init` 方法变得杂乱。

<a id="Instance_Variables_In_Headers_Should_Be_@protected_or_@private"></a>

### 头文件中的实例变量应为 @protected 或 @private

实例变量通常应在实现文件中声明，或由属性自动合成。当实例变量在头文件中声明时，应标记为 `@protected` 或 `@private`。

```objectivec
// 正确：

@interface MyClass : NSObject {
 @protected
  id _myInstanceVariable;
}
@end
```

<a id="Avoid_+new"></a>

### 不要使用 +new

不要调用 `NSObject` 类方法 `new`，也不要在子类中重写它。`+new` 很少使用，且与初始化器的使用方式大相径庭。相反，应使用 `+alloc` 和 `-init` 方法来实例化保留对象。

<a id="Keep_the_Public_API_Simple"></a>

### 保持公共 API 简洁

保持你的类简洁，避免“万能”API。如果某个方法不需要公开，就不要将其放在公共接口中。

与 C++ 不同，Objective-C 不区分公共和私有方法；任何消息都可以发送给对象。因此，除非类消费者确实需要使用这些方法，否则不要将它们放在公共 API 中。这样可以减少它们在你不期望时被调用的可能性。这包括从父类重写的方法。

由于内部方法实际上并非私有，很容易意外地重写超类的“私有”方法，从而造成难以解决的错误。一般来说，私有方法应具有相当独特的名称，以防止子类无意中重写它们。

<a id="#import_and_#include"></a>

### #import 和 #include

`#import` Objective-C 和 Objective-C++ 头文件，`#include` C/C++ 头文件。

C/C++ 头文件使用 `#include` 包含其他 C/C++ 头文件。在 C/C++ 头文件上使用 `#import` 会阻止将来使用 `#include` 进行包含，并可能导致意外的编译行为。

C/C++ 头文件应提供自己的 `#define` 防护。

<a id="Order_of_Includes"></a>

### 包含顺序

头文件包含的标准顺序是相关头文件、操作系统头文件、语言库头文件，最后是其他依赖项的头文件组。

相关头文件优先于其他头文件，以确保它没有隐藏的依赖。对于实现文件，相关头文件是头文件。对于测试文件，相关头文件是包含被测试接口的头文件。

用一空行分隔每个非空的包含组。在每个组内，包含应按字母顺序排列。

使用相对于项目源目录的路径导入头文件。

```objectivec
// 正确：

#import "ProjectX/BazViewController.h"

#import <Foundation/Foundation.h>

#include <unistd.h>
#include <vector>

#include "base/basictypes.h"
#include "base/integral_types.h"
#import "base/mac/FOOComplexNumberSupport"
#include "util/math/mathutil.h"

#import "ProjectX/BazModel.h"
#import "Shared/Util/Foo.h"
```

<a id="Use_Umbrella_Headers_for_System_Frameworks"></a>

### 使用系统框架的伞形头文件

导入系统框架和系统库的伞形头文件，而不是单独包含各个文件。

虽然从 Cocoa 或 Foundation 等框架中包含单个系统头文件似乎很诱人，但实际上，如果你包含顶级根框架，对编译器来说工作量会更少。根框架通常是预编译的，可以更快地加载。此外，请记住，对于 Objective-C 框架，使用 `@import` 或 `#import` 而不是 `#include`。

```objectivec
// 正确：

@import UIKit;     // 正确。
#import <Foundation/Foundation.h>     // 正确。
```

```objectivec
// 避免：

#import <Foundation/NSArray.h>        // 避免。
#import <Foundation/NSString.h>
...
```
### 在初始化器和 `-dealloc` 中避免向当前对象发送消息

在初始化器和 `-dealloc` 中，代码应尽可能避免调用实例方法。

超类初始化完成后，子类才开始初始化。在所有类都有机会初始化其实例状态之前，对 `self` 的任何方法调用都可能导致子类操作未初始化的实例状态。

在 `-dealloc` 中也存在类似的问题，方法调用可能导致类操作已被释放的状态。

一个不太明显的情况是属性访问器。这些可以像任何其他选择器一样被重写。只要可能，在初始化器和 `-dealloc` 中应直接分配和释放实例变量，而不是依赖访问器。

```objectivec
// 正确：

- (instancetype)init {
  self = [super init];
  if (self) {
    _bar = 23;  // 正确。
  }
  return self;
}
```

要注意将常见的初始化代码提取到辅助方法中：

- 方法可以在子类中被重写，无论是有意还是由于命名冲突意外发生。
- 在编辑辅助方法时，可能不明显代码是在初始化器中运行的。

```objectivec
// 避免：

- (instancetype)init {
  self = [super init];
  if (self) {
    self.bar = 23;  // 避免。
    [self sharedMethod];  // 避免。对子类化或未来扩展不稳定。
  }
  return self;
}
```

```objectivec
// 正确：

- (void)dealloc {
  [_notifier removeObserver:self];  // 正确。
}
```

```objectivec
// 避免：

- (void)dealloc {
  [self removeNotifications];  // 避免。
}
```

在初始化过程中，类可能需要使用超类提供的属性和方法。这种情况常见于从 UIKit 和 AppKit 基础类派生的类，以及其他基础类。根据常规做法和您的判断来决定是否对这条规则进行例外处理。

### 避免冗余的属性访问

代码应避免冗余的属性访问。当属性值预计不会改变且需要多次使用时，优先将属性值赋给本地变量。

```objc
// 正确：

UIView *view = self.view;
UIScrollView *scrollView = self.scrollView;
[scrollView.leadingAnchor constraintEqualToAnchor:view.leadingAnchor].active = YES;
[scrollView.trailingAnchor constraintEqualToAnchor:view.trailingAnchor].active = YES;
```

```objc
// 避免：

[self.scrollView.loadingAnchor constraintEqualToAnchor:self.view.loadingAnchor].active = YES;
[self.scrollView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
```

在重复引用链式属性调用时，优先将重复的表达式捕获到本地变量中：

```objc
// 避免：

foo.bar.baz.field1 = 10;
foo.bar.baz.field2 = @"Hello";
foo.bar.baz.field3 = 2.71828183;
```

```objc
// 正确：

Baz *baz = foo.bar.baz;
baz.field1 = 10;
baz.field2 = @"Hello";
baz.field3 = 2.71828183;
```

重复访问相同的属性会导致多次消息分发以获取相同的值，并且在 ARC 下需要对返回的对象进行保留和释放；编译器无法优化这些额外的操作，导致执行速度变慢和二进制文件大小显著增加。


<a id="Mutables_Copies_Ownership"></a>
### 可变性、复制和所有权

对于[包含不可变和可变子类的Foundation和其他层次结构](https://developer.apple.com/library/archive/documentation/General/Conceptual/CocoaEncyclopedia/ObjectMutability/ObjectMutability.html)，只要遵守不可变对象的契约，就可以用可变子类替代不可变对象。

这种替代最常见的例子是所有权转移，特别是对于返回值。在这些情况下，不需要额外的复制，返回可变子类会更有效。[调用者应按声明的类型对待返回值](https://developer.apple.com/library/archive/documentation/General/Conceptual/CocoaEncyclopedia/ObjectMutability/ObjectMutability.html#//apple_ref/doc/uid/TP40010810-CH5-SW67)，因此返回值将被视为不可变对象。

```objectivec
// 正确：

- (NSArray *)listOfThings {
  NSMutableArray *generatedList = [NSMutableArray array];
  for (NSInteger i = 0; i < _someLimit; i++) {
    [generatedList addObject:[self thingForIndex:i]];
  }
  // 不需要复制，generatedList的所有权被转移。
  return generatedList;
}
```

这条规则也适用于只有可变变体的类，只要所有权转移是明确的。Proto就是一个常见的例子。

```objectivec
// 正确：

- (SomeProtoMessage *)someMessageForValue:(BOOL)value {
  SomeProtoMessage *message = [SomeProtoMessage message];
  message.someValue = value;
  return message;
}
```

在调用方法时，如果可变参数在方法调用期间不会改变，则不需要创建一个本地不可变副本来匹配被调用方法的签名。被调用的方法应按声明的类型对待参数，并在需要在调用结束后保留这些参数时，采取[防御性复制](#Defensive_Copies)（[苹果称之为“快照”](https://developer.apple.com/library/archive/documentation/General/Conceptual/CocoaEncyclopedia/ObjectMutability/ObjectMutability.html#//apple_ref/doc/uid/TP40010810-CH5-SW68)）。

```objectivec
// 避免：

NSMutableArray *updatedThings = [NSMutableArray array];
[updatedThings addObject:newThing];
[_otherManager updateWithCurrentThings:[updatedThings copy]];  // 避免
```

<a id="Defensive_Copies"></a>
<a id="Setters_copy_NSStrings"></a>
### 复制可能可变的对象

接收并保留集合或其他具有[可变变体](https://developer.apple.com/library/archive/documentation/General/Conceptual/CocoaEncyclopedia/ObjectMutability/ObjectMutability.html)的类型的代码应考虑到传入的对象可能是可变的，因此应保留一个不可变或可变的副本，而不是原始对象。特别是，初始化器和设置器[应复制而不是保留其类型具有可变变体的对象](https://developer.apple.com/library/archive/documentation/General/Conceptual/CocoaEncyclopedia/ObjectMutability/ObjectMutability.html#//apple_ref/doc/uid/TP40010810-CH5-SW68)。

合成的访问器应使用`copy`关键字，以确保生成的代码符合这些期望。

注意：[`copy`属性关键字仅影响合成的设置器，对获取器没有影响](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ObjectiveC/Chapters/ocProperties.html#//apple_ref/doc/uid/TP30001163-CH17-SW27)。由于属性关键字对直接访问实例变量没有影响，自定义访问器必须实现相同的复制语义。

```objectivec
// 良好示例：

@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSSet<FilterThing *> *filters;

- (instancetype)initWithName:(NSString *)name
                     filters:(NSSet<FilterThing *> *)filters {
  self = [super init];
  if (self) {
    _name = [name copy];
    _filters = [filters copy];
  }
  return self;
}

- (void)setFilters:(NSSet<FilterThing *> *)filters {
  // 确保我们保留一个不可变的集合。
  _filters = [filters copy];
}
```

同样，获取器必须返回与它们返回的不可变类型契约期望相匹配的类型。

```objectivec
// 良好示例：

@implementation Foo {
  NSMutableArray<ContentThing *> *_currentContent;
}

- (NSArray<ContentThing *> *)currentContent {
  return [_currentContent copy];
}

```

所有Objective-C协议都是可变的，通常应复制而不是保留[除非明确涉及所有权转移的情况](#Mutables_Copies_Ownership)。

```objectivec
// 良好示例：

- (void)setFooMessage:(FooMessage *)fooMessage {
  // 复制协议以确保没有其他保留者可以修改我们的值。
  _fooMessage = [fooMessage copy];
}

- (FooMessage *)fooMessage {
  // 复制协议以返回，以便调用者无法修改我们的值。
  return [_fooMessage copy];
}
```

异步代码应在调度前复制可能可变的对象。被块捕获的对象会被保留但不会被复制。

```objectivec
// 良好示例：

- (void)doSomethingWithThings:(NSArray<Thing *> *)things {
  NSArray<Thing *> *thingsToWorkOn = [things copy];
  dispatch_async(_workQueue, ^{
    for (id<Thing> thing in thingsToWorkOn) {
      ...
    }
  });
}
```

注意：没有必要复制没有可变变体的对象，例如`NSURL`，`NSNumber`，`NSDate`，`UIColor`等。

<a id="Use_Lightweight_Generics_to_Document_Contained_Types"></a>

### 使用轻量级泛型来记录包含的类型

所有在Xcode 7或更新版本上编译的项目都应使用Objective-C轻量级泛型表示法来类型化包含的对象。

每个`NSArray`，`NSDictionary`或`NSSet`引用都应使用轻量级泛型声明，以提高类型安全性并明确记录使用情况。

```objectivec
// 良好示例：

@property(nonatomic, copy) NSArray<Location *> *locations;
@property(nonatomic, copy, readonly) NSSet<NSString *> *identifiers;

NSMutableArray<MyLocation *> *mutableLocations = [otherObject.locations mutableCopy];
```

如果完全注释的类型变得复杂，可以考虑使用typedef来保持可读性。

```objectivec
// 良好示例：

typedef NSSet<NSDictionary<NSString *, NSDate *> *> TimeZoneMappingSet;
TimeZoneMappingSet *timeZoneMappings = [TimeZoneMappingSet setWithObjects:...];
```

使用最具描述性的公共超类或协议。如果在最通用的情况下没有任何其他信息，请使用id明确声明集合为异构的。

```objectivec
// 良好示例：

@property(nonatomic, copy) NSArray<id> *unknowns;
```

<a id="Avoid_Throwing_Exceptions"></a>
### 避免抛出异常

不要使用 `@throw` 抛出 Objective-C 异常，但你应该准备好捕获来自第三方或操作系统调用的异常。

这遵循了苹果在 [Cocoa 异常编程主题介绍](https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/Exceptions/Exceptions.html) 中关于使用错误对象传递错误的建议。

我们确实使用 `-fobjc-exceptions` 进行编译（主要是为了使用 `@synchronized`），但我们不使用 `@throw`。在需要正确使用第三方代码或库时，允许使用 `@try`、`@catch` 和 `@finally`。如果你使用了它们，请准确记录你期望抛出异常的方法。

<a id="nil_Checks"></a>

### `nil` 检查

避免仅为了防止向 `nil` 发送消息而存在的 `nil` 指针检查。向 `nil` 发送消息会[可靠地返回](http://www.sealiesoftware.com/blog/archive/2012/2/29/objc_explain_return_value_of_message_to_nil.html) 指针的 `nil`，整数或浮点值的零，初始化为 `0` 的结构体，以及等于 `{0, 0}` 的 `_Complex` 值。

```objectivec
// 避免：

if (dataSource) {  // 避免。
  [dataSource moveItemAtIndex:1 toIndex:0];
}
```

```objectivec
// 推荐：

[dataSource moveItemAtIndex:1 toIndex:0];  // 推荐。
```

请注意，这适用于 `nil` 作为消息目标，而不是作为参数值。各个方法可能可以或不可以安全处理 `nil` 参数值。

还要注意，这与检查 C/C++ 指针和块指针是否为 `NULL` 不同，运行时不会处理这种情况，并且会导致你的应用程序崩溃。你仍然需要确保不解引用 `NULL` 指针。

### 可空性

接口可以使用可空性注解进行装饰，以描述接口的使用方式和行为。可空性区域的使用（例如，`NS_ASSUME_NONNULL_BEGIN` 和 `NS_ASSUME_NONNULL_END`）和显式的可空性注解都被接受。优先使用 `_Nullable` 和 `_Nonnull` 关键字，而不是 `__nullable` 和 `__nonnull` 关键字。对于 Objective-C 方法和属性，优先使用上下文敏感的、非下划线的关键字，例如 `nonnull` 和 `nullable`。

```objectivec
// 推荐：

/** 表示拥有的书的类。 */
@interface GTMBook : NSObject

/** 书的标题。 */
@property(nonatomic, readonly, copy, nonnull) NSString *title;

/** 书的作者，如果存在的话。 */
@property(nonatomic, readonly, copy, nullable) NSString *author;

/** 书的所有者。设置为 nil 会重置为默认所有者。 */
@property(nonatomic, copy, null_resettable) NSString *owner;

/** 使用标题和可选的作者初始化一本书。 */
- (nonnull instancetype)initWithTitle:(nonnull NSString *)title
                               author:(nullable NSString *)author
    NS_DESIGNATED_INITIALIZER;

/** 返回 nil，因为预期书籍应有标题。 */
- (nullable instancetype)init;

@end

/** 从指定路径的文件中加载书籍。 */
NSArray<GTMBook *> *_Nullable GTMLoadBooksFromFile(NSString *_Nonnull path);
```

```objectivec
// 避免：

NSArray<GTMBook *> *__nullable GTMLoadBooksFromTitle(NSString *__nonnull path);
```

不要基于 `nonnull` 限定符假设指针不为 null，因为编译器只检查此类情况的一部分，并且不保证指针不为 null。避免故意违反函数、方法和属性声明的可空性语义。

<a id="BOOL_Pitfalls"></a>
### BOOL 的陷阱

<a id="BOOL_Expressions_Conversions"></a>
#### BOOL 表达式和转换

在将一般整数值转换为 `BOOL` 时要小心。避免直接与 `YES` 进行比较，或使用比较运算符比较多个 `BOOL` 值。

在某些 Apple 平台上（特别是 Intel macOS、watchOS 和 32 位 iOS），`BOOL` 被定义为有符号的 `char`，因此它可能具有除 `YES` (`1`) 和 `NO` (`0`) 之外的值。不要直接将一般整数值转换或强制转换为 `BOOL`。

常见的错误包括将数组大小、指针值或位逻辑运算的结果转换或强制转换为 `BOOL`。这些操作可能依赖于整数值的最后一个字节的值，并可能导致意外的 `NO` 值。使用 NS_OPTIONS 值和标志掩码的操作尤其容易出错。

在将一般整数值转换为 `BOOL` 时，使用条件运算符返回 `YES` 或 `NO` 值。

您可以安全地互换和转换 `BOOL`、`_Bool` 和 `bool`（参见 C++ Std 4.7.4、4.12 和 C99 Std 6.3.1.2）。在 Objective-C 方法签名中使用 `BOOL`。

使用逻辑运算符（`&&`、`||` 和 `!`）与 `BOOL` 一起使用也是有效的，并且返回的值可以安全地转换为 `BOOL`，无需使用条件运算符。

```objectivec
// 避免：

- (BOOL)isBold {
  return [self fontTraits] & NSFontBoldTrait;  // 避免。
}
- (BOOL)isValid {
  return [self stringValue];  // 避免。
}
- (BOOL)isLongEnough {
  return (BOOL)([self stringValue].count);  // 避免。
}
```

```objectivec
// 正确：

- (BOOL)isBold {
  return ([self fontTraits] & NSFontBoldTrait) ? YES : NO;
}
- (BOOL)isValid {
  return [self stringValue] != nil;
}
- (BOOL)isLongEnough {
  return [self stringValue].count > 0;
}
- (BOOL)isEnabled {
  return [self isValid] && [self isBold];
}
```

不要直接将 `BOOL` 变量与 `YES` 直接比较。这样不仅对于精通 C 语言的人来说更难阅读，而且上面第一点也表明返回值可能并不总是您所期望的。

```objectivec
// 避免：

BOOL great = [foo isGreat];
if (great == YES) {  // 避免。
  // ...做伟大的事情！
}
```

```objectivec
// 正确：

BOOL great = [foo isGreat];
if (great) {         // 正确。
  // ...做伟大的事情！
}
```

不要直接使用比较运算符比较 `BOOL` 值。真值的 `BOOL` 可能不相等。使用逻辑运算符代替 `BOOL` 值的位比较。

```objectivec
// 避免：

if (oldBOOLValue != newBOOLValue) {  // 避免。
  // ...仅当值发生变化时运行的代码。
}
```

```objectivec
// 正确：

if ((!oldBoolValue && newBoolValue) || (oldBoolValue && !newBoolValue)) {  // 正确。
  // ...仅当值发生变化时运行的代码。
}

// 正确，逻辑运算符对 BOOL 的结果是安全的，可以进行比较。
if (!oldBoolValue != !newBoolValue) {
  // ...仅当值发生变化时运行的代码。
}
```

#### BOOL 字面量

[BOOL NSNumber 字面量](https://clang.llvm.org/docs/ObjectiveCLiterals.html#nsnumber-literals)
是 `@YES` 和 `@NO`，它们等同于 `[NSNumber numberWithBool:...]`。

避免使用 [boxed expressions](https://clang.llvm.org/docs/ObjectiveCLiterals.html#boxed-expressions)
创建 BOOL 值，包括简单的表达式如 `@(YES)`。boxed expressions 存在与其他 BOOL 表达式相同的问题
(#BOOL_Expressions_Conversions)，因为将一般整数值装箱可能会产生不等于 `@YES` 和 `@NO` 的真或假 `NSNumbers`。

在将一般整数值转换为 BOOL 字面量时，使用条件运算符转换为 `@YES` 或 `@NO`。不要在 boxed expression 中嵌入条件运算符，因为这相当于即使操作结果是 BOOL 也对一般整数值进行装箱。

```objectivec
// 避免：

[_boolArray addValue:@(YES)];  // 避免即使在简单情况下也进行装箱。
NSNumber *isBold = @(self.fontTraits & NSFontBoldTrait);  // 避免。
NSNumber *hasContent = @([self stringValue].length);  // 避免。
NSNumber *isValid = @([self stringValue]);  // 避免。
NSNumber *isStringNotNil = @([self stringValue] ? YES : NO);  // 避免。
```

```objectivec
// 正确：

[_boolArray addValue:@YES];  // 正确。
NSNumber *isBold = self.fontTraits & NSFontBoldTrait ? @YES : @NO;  // 正确。
NSNumber *hasContent = [self stringValue].length ? @YES : @NO;  // 正确。
NSNumber *isValid = [self stringValue] ? @YES : @NO;  // 正确。
```objectivec
NSNumber *isStringNotNil = [self stringValue] ? @YES : @NO;  // 良好。
```

<a id="Interfaces_Without_Instance_Variables"></a>
<a id="interfaces-without-instance-variables"></a>

### 不包含实例变量的容器

在没有实例变量声明的接口、类扩展和实现中，省略空的大括号。

```objectivec
// 良好：

@interface MyClass : NSObject
// 执行许多操作。
- (void)fooBarBam;
@end

@interface MyClass ()
- (void)classExtensionMethod;
@end

@implementation MyClass
// 实际实现。
@end
```

```objectivec
// 避免：

@interface MyClass : NSObject {
}
// 执行许多操作。
- (void)fooBarBam;
@end

@interface MyClass () {
}
- (void)classExtensionMethod;
@end

@implementation MyClass {
}
// 实际实现。
@end
```

<a id="Cocoa_Patterns"></a>

## Cocoa 模式

<a id="Delegate_Pattern"></a>

### 委托模式

在执行操作时，委托、目标对象和块指针不应被保留，以避免创建保留循环。

为了避免造成保留循环，委托或目标指针应在明确不再需要发送消息给对象时立即释放。

如果没有明确的时间点表明不再需要委托或目标指针，则应仅以弱引用方式保留该指针。

块指针不能以弱引用方式保留。为了避免在客户端代码中造成保留循环，块指针应仅在明确可以在调用后或不再需要时释放的情况下用于回调。否则，应通过弱委托或目标指针进行回调。

<a id="Objective-C++"></a>

## Objective-C++

<a id="Style_Matches_the_Language"></a>

### 风格与语言匹配

在 Objective-C++ 源文件中，遵循所实现的函数或方法的语言风格。为了在混合使用 Cocoa/Objective-C 和 C++ 时尽量减少命名风格的冲突，应遵循所实现的方法的风格。

在 `@implementation` 块中，使用 Objective-C 命名规则。对于 C++ 类的某个方法中的代码，使用 C++ 命名规则。

对于类实现之外的 Objective-C++ 文件中的代码，在文件内保持一致。

```objectivec++
// 良好：

// 文件：cross_platform_header.h

class CrossPlatformAPI {
 public:
  ...
  int DoSomethingPlatformSpecific();  // 在每个平台上实现
 private:
  int an_instance_var_;
};

// 文件：mac_implementation.mm
#include "cross_platform_header.h"

/** 一个典型的 Objective-C 类，使用 Objective-C 命名规则。 */
@interface MyDelegate : NSObject {
 @private
  int _instanceVar;
  CrossPlatformAPI* _backEndObject;
}

- (void)respondToSomething:(id)something;

@end

@implementation MyDelegate

- (void)respondToSomething:(id)something {
  // 通过我们的 C++ 后端从 Cocoa 桥接
  _instanceVar = _backEndObject->DoSomethingPlatformSpecific();
  NSString* tempString = [NSString stringWithFormat:@"%d", _instanceVar];
  NSLog(@"%@", tempString);
}

@end

/** C++ 类的平台特定实现，使用 C++ 命名规则。 */
int CrossPlatformAPI::DoSomethingPlatformSpecific() {
  NSString* temp_string = [NSString stringWithFormat:@"%d", an_instance_var_];
  NSLog(@"%@", temp_string);
  return [temp_string intValue];
}
```

项目可以选择使用 80 列的行长度限制，以与 Google 的 C++ 风格指南保持一致。

<a id="Spacing_and_Formatting"></a>

## 间距和格式

<a id="Spaces_vs._Tabs"></a>

### 空格与制表符

仅使用空格，每次缩进 2 个空格。我们使用空格进行缩进。不要在代码中使用制表符。

您应该设置编辑器在按下制表键时发出空格，并在行尾修剪多余的空格。

<a id="Line_Length"></a>

### 行长度

Objective-C 文件的最大行长度为 100 列。

<a id="Method_Declarations_and_Definitions"></a>
### 方法声明和定义

在 `-` 或 `+` 与返回类型之间应使用一个空格。一般来说，参数列表中除了参数之间外不应有空格。

方法应如下所示：

```objectivec
// 良好示例：

- (void)doSomethingWithString:(NSString *)theString {
  ...
}
```

星号前的空格是可选的。在添加新代码时，应与周围文件的风格保持一致。

如果方法声明不能在一行内完成，应将每个参数放在单独的一行上。除了第一行外，所有行至少应缩进四个空格。参数前的冒号应在所有行上对齐。如果第一行方法声明中参数前的冒号位置使得后续行的缩进少于四个空格，则只需对除第一行之外的所有行进行冒号对齐。如果在方法声明或定义中 `:` 后的参数会导致超出行限制，则应将内容换行到下一行，并至少缩进四个空格。

```objectivec
// 良好示例：

- (void)doSomethingWithFoo:(GTMFoo *)theFoo
                      rect:(NSRect)theRect
                  interval:(float)theInterval {
  ...
}

- (void)shortKeyword:(GTMFoo *)theFoo
            longerKeyword:(NSRect)theRect
    someEvenLongerKeyword:(float)theInterval
                    error:(NSError **)theError {
  ...
}

- (id<UIAdaptivePresentationControllerDelegate>)
    adaptivePresentationControllerDelegateForViewController:(UIViewController *)viewController;

- (void)presentWithAdaptivePresentationControllerDelegate:
    (id<UIAdaptivePresentationControllerDelegate>)delegate;

- (void)updateContentHeaderViewForExpansionToContentOffset:(CGPoint)contentOffset
                                            withController:
                                                (GTMCollectionExpansionController *)controller;

```

### 函数声明和定义

优先将返回类型放在与函数名相同的行上，如果参数能在一行内容纳，则应将所有参数附加在同一行上。对于不能在一行内容纳的参数列表，应像处理[函数调用](#Function_Calls)中的参数那样进行换行。

```objectivec
// 良好示例：

NSString *GTMVersionString(int majorVersion, int minorVersion) {
  ...
}

void GTMSerializeDictionaryToFileOnDispatchQueue(
    NSDictionary<NSString *, NSString *> *dictionary,
    NSString *filename,
    dispatch_queue_t queue) {
  ...
}
```

函数声明和定义还应满足以下条件：

*   左括号必须始终与函数名在同一行上。
*   如果无法在一行内容纳返回类型和函数名，则在它们之间断行，且不要缩进函数名。
*   左括号前永远不应有空格。
*   函数括号与参数之间永远不应有空格。
*   左大括号始终位于函数声明的最后一行的末尾，而不是下一行的开头。
*   右大括号要么单独位于最后一行，要么与左大括号位于同一行。
*   右括号与左大括号之间应有一个空格。
*   如果可能，所有参数应对齐。
*   函数作用域应缩进2个空格。
*   换行的参数应缩进4个空格。

<a id="Conditionals"></a>

### 条件语句

在 `if`、`while`、`for` 和 `switch` 之后，以及比较运算符周围应包含一个空格。

```objectivec
// 良好示例：

for (int i = 0; i < 5; ++i) {
}

while (test) {};
```

当循环体或条件语句在一行内可以容纳时，可以省略大括号。

```objectivec
// 良好示例：

if (hasSillyName) LaughOutLoud();

for (int i = 0; i < 10; i++) {
  BlowTheHorn();
}
```

```objectivec
// 避免：

if (hasSillyName)
  LaughOutLoud();               // 避免。

for (int i = 0; i < 10; i++)
  BlowTheHorn();                // 避免。
```

如果 `if` 子句有 `else` 子句，则两个子句都应使用大括号。

```objectivec
// 良好示例：

if (hasBaz) {
  foo();
} else {  // else 应与闭合大括号在同一行。
  bar();
}
```

```objectivec
// 避免：

if (hasBaz) foo();
else bar();        // 避免。

if (hasBaz) {
  foo();
} else bar();      // 避免。
```

有意落入下一 case 时，除非 case 之间没有中间代码，否则应使用注释进行说明。

```objectivec
// 良好示例：

switch (i) {
  case 1:
    ...
    break;
  case 2:
    j++;
    // 落入下一 case。
  case 3: {
    int k;
    ...
    break;
  }
  case 4:
  case 5:
  case 6: break;
}
```

<a id="Expressions"></a>
### 表达式

在二元运算符和赋值操作符周围使用空格。对于一元运算符则不使用空格。在括号内不添加空格。

```objectivec
// 正确：

x = 0;
v = w * x + y / z;
v = -y * (x + z);
```

表达式中的因子可以省略空格。

```objectivec
// 正确：

v = w*x + y/z;
```

<a id="Method_Invocations"></a>

### 方法调用

方法调用的格式应与方法声明类似。

当有多种格式风格可选时，应遵循已在给定源文件中使用的惯例。方法调用应将所有参数放在一行上：

```objectivec
// 正确：

[myObject doFooWith:arg1 name:arg2 error:arg3];
```

或者每个参数一行，冒号对齐：

```objectivec
// 正确：

[myObject doFooWith:arg1
               name:arg2
              error:arg3];
```

避免使用以下任何一种风格：

```objectivec
// 避免：

[myObject doFooWith:arg1 name:arg2  // 某些行包含多个参数
              error:arg3];

[myObject doFooWith:arg1
               name:arg2 error:arg3];

[myObject doFooWith:arg1
          name:arg2  // 对齐关键字而不是冒号
          error:arg3];
```

与声明和定义一样，当第一个关键字比其他关键字短时，后续行应至少缩进四个空格，同时保持冒号对齐：

```objectivec
// 正确：

[myObj short:arg1
          longKeyword:arg2
    evenLongerKeyword:arg3
                error:arg4];
```

包含多个内联块的方法调用可以将其参数名称左对齐，缩进四个空格。

<a id="Function_Calls"></a>

### 函数调用

函数调用应包含尽可能多的参数，除非为了清晰度或参数文档的需要而需要较短的行。

函数参数的续行可以与左括号对齐，或者缩进四个空格。

```objectivec
// 正确：

CFArrayRef array = CFArrayCreate(kCFAllocatorDefault, objects, numberOfObjects,
                                 &kCFTypeArrayCallBacks);

NSString *string = NSLocalizedStringWithDefaultValue(@"FEET", @"DistanceTable",
    resourceBundle,  @"%@ feet", @"Distance for multiple feet");

UpdateTally(scores[x] * y + bases[x],  // 分数启发式。
            x, y, z);

TransformImage(image,
               x1, x2, x3,
               y1, y2, y3,
               z1, z2, z3);
```

使用具有描述性名称的局部变量来缩短函数调用并减少调用的嵌套。

```objectivec
// 正确：

double scoreHeuristic = scores[x] * y + bases[x];
UpdateTally(scoreHeuristic, x, y, z);
```

<a id="Exceptions"></a>

### 异常

使用 `@catch` 和 `@finally` 标签与前面的 `}` 位于同一行。`@` 标签与左大括号 `{` 之间以及 `@catch` 与捕获的对象声明之间添加一个空格。如果必须使用 Objective-C 异常，请按以下格式进行格式化。然而，请参阅 [避免抛出异常](#Avoid_Throwing_Exceptions) 了解为什么不应使用异常。

```objectivec
// 正确：

@try {
  foo();
} @catch (NSException *ex) {
  bar(ex);
} @finally {
  baz();
}
```

<a id="Function_Length"></a>

### 函数长度

偏好小而集中的函数。

长函数和方法偶尔是合适的，因此没有对函数长度设定硬性限制。如果一个函数超过大约 40 行，请考虑是否可以在不损害程序结构的情况下将其拆分。

即使你的长函数现在运行得很完美，几个月后有人修改它时可能会添加新行为。这可能会导致难以发现的错误。保持你的函数短小简单，可以让其他人更容易阅读和修改你的代码。

在更新遗留代码时，也要考虑将长函数分解成更小、更易管理的部分。

<a id="Vertical_Whitespace"></a>

### 垂直空白

谨慎使用垂直空白。

为了让屏幕上可以更容易地查看更多代码，避免在函数的大括号内刚开始就添加空行。

将空行限制在一到两行之间，用于函数之间和代码的逻辑分组之间。

<a id="Objective-C_Style_Exceptions"></a>

## Objective-C 风格例外

<a id="Indicating_style_exceptions"></a>
### 指示样式例外

那些不需要遵循这些样式建议的代码行，需要在行尾添加 `// NOLINT`，或者在前一行的行尾添加 `// NOLINTNEXTLINE`。有时，Objective-C 代码的某些部分必须忽略这些样式建议（例如，代码可能是机器生成的，或者代码结构使得无法正确应用样式）。

在该行上添加 `// NOLINT` 注释，或者在前一行添加 `// NOLINTNEXTLINE`，可以向读者表明代码是有意忽略样式指南的。此外，这些注释还可以被自动化工具（如代码检查器）识别，并正确处理代码。请注意，`//` 和 `NOLINT*` 之间有一个空格。