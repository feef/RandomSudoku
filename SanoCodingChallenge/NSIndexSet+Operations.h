#import <Foundation/Foundation.h>

@interface NSIndexSet (Operations)

// http://en.wikipedia.org/wiki/Union_(set_theory)
- (NSIndexSet *)unionWith:(NSIndexSet *)other;

// http://en.wikipedia.org/wiki/Intersection_(set_theory)
- (NSIndexSet *)intersectionWith:(NSIndexSet *)other;

// http://en.wikipedia.org/wiki/Complement_(set_theory)#Relative_complement
- (NSIndexSet *)relativeComplementIn:(NSIndexSet *)universe;

// http://en.wikipedia.org/wiki/Symmetric_difference
- (NSIndexSet *)symmetricDifferenceWith:(NSIndexSet *)other;

@end

@interface NSIndexSet (RangeOperations)

- (NSIndexSet *)unionWithRange:(NSRange)range;
- (NSIndexSet *)intersectionWithRange:(NSRange)range;
- (NSIndexSet *)relativeComplementInRange:(NSRange)range;
- (NSIndexSet *)symmetricDifferenceWithRange:(NSRange)range;

@end
