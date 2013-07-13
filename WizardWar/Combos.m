//
//  Combos.m
//  WizardWar
//
//  Created by Sean Hess on 5/31/13.
//  Copyright (c) 2013 The LAB. All rights reserved.
//

#import "Combos.h"
#import "SpellFireball.h"
#import "SpellEarthwall.h"
#import "SpellBubble.h"
#import "SpellMonster.h"
#import "SpellVine.h"
#import "SpellWindblast.h"
#import "SpellIcewall.h"
#import "SpellInvisibility.h"
#import "SpellFirewall.h"
#import "SpellFist.h"
#import "SpellHelmet.h"
#import "SpellHeal.h"
#import "SpellLevitate.h"
#import "SpellSleep.h"
#import "NSArray+Functional.h"

@interface Combos ()
@property (strong, nonatomic) NSDictionary * hitCombos;
@property (nonatomic, strong) Spell * lastSuccessfulSpell;

@end

@implementation Combos

-(id)init {
    self = [super init];
    if (self) {
        self.hitCombos = [Combos createHitCombos];
        self.allElements = [NSMutableArray array];
    }
    return self;
}

-(void)moveToElement:(ElementType)element {
    self.lastElement = element;
    [self.allElements addObject:@(element)];
    self.hintedSpell = [self spellForElements:self.allElements];
}

-(void)releaseElements {
    
    // Can't cast the same spell twice!
    if (self.sameSpellTwice) {
        self.hintedSpell = nil;
    }
    
    self.castSpell = self.hintedSpell;
    self.hintedSpell = nil;
    self.allElements = [NSMutableArray array];
    
    if (self.castSpell) {
        self.lastSuccessfulSpell = self.castSpell;
    }
}

-(BOOL)sameSpellTwice {
    return (self.hintedSpell && self.lastSuccessfulSpell.class == self.hintedSpell.class);
}

+(NSDictionary*)createHitCombos {
    NSMutableDictionary * hitCombos = [NSMutableDictionary dictionary];
        // 1 and 2 combos
//    hitCombos[@"_____"] = nil;
//    hitCombos[@"A____"] = nil;
//    hitCombos[@"_E___"] = nil;
//    hitCombos[@"__F__"] = nil;
//    hitCombos[@"___H_"] = nil;
//    hitCombos[@"____W"] = nil;
//    hitCombos[@"AE___"] = nil;
//    hitCombos[@"A_F__"] = nil;
//    hitCombos[@"A__H_"] = nil;
//    hitCombos[@"A___W"] = nil;
//    hitCombos[@"_EF__"] = nil;
//    hitCombos[@"_E_H_"] = nil;
//    hitCombos[@"_E__W"] = nil;
//    hitCombos[@"__FH_"] = nil;
//    hitCombos[@"__F_W"] = nil;
//    hitCombos[@"___HW"] = nil;
    
    // Walls: spells initially go through it
    // Ice Walls: hurting monsters and stuff.
    // Fist break helmet? Could pick where horizontally it comes down. 
    
    // 3 combos
    
    hitCombos[@"AEF__"] = [SpellFirewall class];
    hitCombos[@"AE_H_"] = [SpellHeal class];
    hitCombos[@"AE__W"] = [SpellSleep class]; // Tornado, Geyser, Sleep,
    hitCombos[@"A_FH_"] = [SpellFireball class];
    hitCombos[@"A_F_W"] = [SpellWindblast class];
    hitCombos[@"A__HW"] = [SpellLevitate class];
    hitCombos[@"_EFH_"] = [SpellHelmet class];
    hitCombos[@"_EF_W"] = [SpellEarthwall class];
    hitCombos[@"_E_HW"] = [SpellIcewall class]; // hurts monsters. goes down. 
    hitCombos[@"__FHW"] = [SpellBubble class];
    
    // 4 combos
    hitCombos[@"AEFH_"] = [NSObject class];
    hitCombos[@"AEF_W"] = [SpellVine class];
    hitCombos[@"AE_HW"] = [SpellFist class];
    hitCombos[@"A_FHW"] = [SpellInvisibility class];
    hitCombos[@"_EFHW"] = [SpellMonster class];
    
    // 5 combos
    hitCombos[@"AEFHW"] = [NSObject class];
    
    return hitCombos;
}

//+(NSDictionary*)hitElements:(NSArray*)elements {
//    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
//    for (NSString * element in elements) {
//        [dict setObject:[NSNumber numberWithBool:YES] forKey:element];
//    }
//    return dict;
//}
//
//+(BOOL)hits:(NSDictionary*)hits containsElements:(NSArray*)elements {
//    for (NSString * element in elements) {
//        if (![hits objectForKey:element]) return NO;
//    }
//    
//    return YES;
//}

//+(BOOL)hits:(NSDictionary*)hits isEqualToElements:(NSArray*)elements {
//    return (elements.count == hits.count && [self hits:hits containsElements:elements]);
//}


// Produces a string key that represents whether or not each one is held down
+(NSString*)hitKey:(NSArray*)elements {
    NSMutableString * key = [NSMutableString stringWithString:@"_____"];
    [elements forEach:^(NSNumber * elementNumber) {
        ElementType element = elementNumber.intValue;
        NSString * elementId = [Elements elementId:element];
        [key replaceCharactersInRange:NSMakeRange(element, 1) withString:elementId];
    }];
    return key;
}


// COMBOS AEFHW

-(Spell*)spellForElements:(NSArray*)elements {
    
    NSString * key = [Combos hitKey:elements];
    Class SpellClass = self.hitCombos[key];
    if (SpellClass != [NSObject class])
        return [SpellClass new];

    return nil;
}

@end
