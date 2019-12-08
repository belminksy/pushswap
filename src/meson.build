
src = [
    'PushChroma/Main.vala',
    'PushChroma/PushChroma.vala',
    'Pushswap/Interpreter.vala',
    'Pushswap/Parser.vala',
    'Pushswap/Token.vala',
    'Util/DoublyCircularLinkedList.vala',
    'Util/Node.vala',
    'Widgets/Canvas.vala'
]

executable(
    meson.project_name(),
    src,
    dependencies: [
        dependency('gtk+-3.0'),
        dependency('gio-2.0'),
        meson.get_compiler('c').find_library('m', required : true)
    ]
)
