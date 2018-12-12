//
//  CategoryViewController.m
//  PGQDemo
//
//  Created by Lois_pan on 2018/8/20.
//  Copyright © 2018年 Lois_pan. All rights reserved.
//
/**
 Category实际上就是一个指向objc_class结构体的指针
 typedef struct objc_class * Class;
 struct objc_class {
 Class isa OBJC_ISA_AVAILABILITY;
 #if !_OBJC2_
 Class super_class
 const char *name
 long version
 long info
 long instance_size
 struct objc_ivar_list *ivars
 struct objc_method_list **methodLists
 struct objc_ptotocol_list *protocols
 #endif
 }OBJC2_UNAVAILANBLE;
 
 Category 不能添加成员变量，但是可以添加属性
 Category的结构体
 
 typedef struct category_t{
 const char *name;
 classres_t cls;
 struct method_list_t *intanceMethods;
 struct method_list_t *classMethods;
 struct protocol_list_t *prococols;
 struct property_list_t * instanceProperties;
 
 }catefgory_t;
 
 extension在编译期决议，它就是类的一部分，但是category则完全不一样，它是在运行期决议的。extension在编译期和头文件里的@interface以及实现文件里的@implement一起形成一个完整的类， 它、extension伴随类的产生而产生，亦随之一起消亡。
 extension一般用来隐藏类的私有信息，你必须有一个类的源码才能为一个类添加extension，所以你无法为系统的类比如NSString添加extension，除非创建子类再添加extension。而category不需要 有类的源码，我们可以给系统提供的类添加category。
 extension可以添加实例变量，而category不可以。
 extension和category都可以添加属性，但是category的属性不能生成成员变量和getter、setter方法的实现。
 
 **/
#import "CategoryViewController.h"

@interface CategoryViewController ()

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)dealloc {
    
}


@end
