function join(array, start, end, sep, result, i)
{
    result = ""
    for (i = start; i <= end; i++)
        result = result sep array[i]
    return result
}
