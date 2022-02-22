using Luxor

mutable struct node
    name::String
    x::Int64
    y::Int64

end


mutable struct member
    name::String
    nodei::node
    nodej::node
end

nodes = [
node("P1", 0, 0), node("P2", 0, 0),
node("P3", 0, 0), node("P4", 0, 0),
node("P5", 0, 0), node("P6", 0, 0),
node("P6", 0, 0)
]

elements = [
member("E1", nodes[1], nodes[2]), member("E2", nodes[2], nodes[3]),
member("E3", nodes[1], nodes[1]), member("E4", nodes[1], nodes[1]),
member("E5", nodes[1], nodes[1]), member("E6", nodes[1], nodes[1]),
member("E7", nodes[1], nodes[1]), member("E8", nodes[1], nodes[1]),
member("E9", nodes[1], nodes[1]), member("E10", nodes[1], nodes[1])
]


##
function edit_node()

    i = 1
    while i <= numNodes
        println("X value of node: ", i)
        x = readline()
        x = parse(Int64, x)

        println("Y value of node: ", i)
        y = readline()
        y = parse(Int64, y)
        y = -y

        nodes[i].x = x
        nodes[i].y = y

        println(nodes[i])



        if i == numNodes
            i = 1
            break
        end

        i += 1

    end


end

function edit_element()

    i = 1
    while i <= numElements
        println("node i for element: ", i)
        x = readline()
        x = parse(Int64, x)
        nodei = nodes[x]

        println("node j for element: ", i)
        y = readline()
        y = parse(Int64, y)
        nodej = nodes[y]

        elements[i].nodei = nodei
        elements[i].nodej = nodej

        println(elements[i])



        if i == numElements
            i = 1
            break
        end

        i += 1

    end


end

function construct_point(node)
    x = node.x
    y = node.y

    return x, y
end


function construct_line(element)
        node1 = element.nodei
        node2 = element.nodej

        p1 = construct_point(node1)
        p2 = construct_point(node2)

        A = Point(p1)
        B = Point(p2)
        line(A, B, :stroke)

end

function construct_image(elements)
    i = 1
    while i <= numElements
        construct_line(elements[i])
        i += 1
    end
end

function fix_y_coords()
    i = 1
    println()
    println("Fixed Y values")
        while i <= numNodes
            nodes[i].y = -1 * nodes[i].y
            println(nodes[i])
            i += 1

        end
end

##



println("Number of nodes:")
userInput = readline()
numNodes = parse(Int64, userInput)


println("Number of elements:")
userInput = readline()
numElements = parse(Int64, userInput)

edit_node()
edit_element()


@png begin
construct_image(elements)


fix_y_coords()
end
