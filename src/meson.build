
src = [
    'PushChroma/Main.vala',
    'PushChroma/PushChroma.vala',
    'Widgets/Canvas.vala'
]

executable(
    meson.project_name(),
    src,
    dependencies: [
        dependency('gtk+-3.0'),
        meson.get_compiler('c').find_library('m', required : true)
    ]
)
