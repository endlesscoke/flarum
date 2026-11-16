<?php

/*
 * This file is part of Flarum.
 *
 * For detailed copyright and license information, please view the
 * LICENSE file that was distributed with this source code.
 */

use Flarum\Extend;
use Flarum\Frontend\Document;

return [
    (new Extend\Frontend('forum'))
        ->css(__DIR__ . '/less/forum.less')
        ->content(function (Document $document) {
            $document->head[] = '<meta name="theme-color" content="#0b0f14">';
            $document->head[] = '<link rel="preconnect" href="https://fonts.googleapis.com">';
            $document->head[] = '<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>';
            $document->head[] = '<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">';
        }),
];
