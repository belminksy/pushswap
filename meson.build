project(
    'pushchroma',
    'vala', 'c',
    version: '0.1'
)

deps = [
    dependency('gtk+-3.0'),
    dependency('gio-2.0'),
    meson.get_compiler('c').find_library('m', required : true)
]

subdir('src')
