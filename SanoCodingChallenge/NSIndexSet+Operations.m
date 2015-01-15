#import "NSIndexSet+Operations.h"

@implementation NSIndexSet (Operations)

- (NSIndexSet *)unionWith:(NSIndexSet *)other
{
    NSMutableIndexSet *result = [self mutableCopy];
    [result addIndexes:other];
    return result;
}

- (NSIndexSet *)intersectionWith:(NSIndexSet *)other
{
    // Create a union of A and B, then
    // remove the symmetric difference
    // of A and B in the union.
    // Formally: (A ∪ B) \ (A ∆ B) = A ∩ B
    NSMutableIndexSet *result = [self mutableCopy];
    [result addIndexes:other];
    [result removeIndexes:[self symmetricDifferenceWith:other]];
    return result;
}

- (NSIndexSet *)relativeComplementIn:(NSIndexSet *)universe
{
    NSMutableIndexSet *complement = [universe mutableCopy];
    [complement removeIndexes:self];
    return complement;
}

- (NSIndexSet *)symmetricDifferenceWith:(NSIndexSet *)other
{
    NSMutableIndexSet *a = [self mutableCopy];
    NSMutableIndexSet *b = [other mutableCopy];
    [a removeIndexes:other];
    [b removeIndexes:self];
    [a addIndexes:b];
    return a;
}

@end

@implementation NSIndexSet (RangeOperations)

- (NSIndexSet *)unionWithRange:(NSRange)range
{
    NSMutableIndexSet *result = [self mutableCopy];
    [result addIndexesInRange:range];
    return result;
}

- (NSIndexSet *)intersectionWithRange:(NSRange)range
{
    return [self intersectionWith:[NSIndexSet indexSetWithIndexesInRange:range]];
}

- (NSIndexSet *)relativeComplementInRange:(NSRange)range
{
    NSMutableIndexSet *complement = [NSMutableIndexSet indexSetWithIndexesInRange:range];
    [complement removeIndexes:self];
    return complement;
}

- (NSIndexSet *)symmetricDifferenceWithRange:(NSRange)range
{
    return [self symmetricDifferenceWith:[NSIndexSet indexSetWithIndexesInRange:range]];
}

@end
